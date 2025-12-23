#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class LinkSpec:
    link: Path
    target: Path
    platform: str
    enabled: bool


def _repo_root_from_script_location() -> Path:
    # Assumes this file is at: <repo_root>/scripts/apply_symlinks.py
    return Path(__file__).resolve().parents[1]


def _load_specs(config_path: Path) -> list[LinkSpec]:
    raw = json.loads(config_path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise ValueError("Config must be a JSON array.")

    specs: list[LinkSpec] = []
    for entry in raw:
        if not isinstance(entry, dict):
            raise ValueError("Each platform entry must be an object.")
        platform = str(entry.get("platform", "")).strip() or "unknown"
        symlinks = entry.get("symlinks", [])
        if symlinks is None:
            continue
        if not isinstance(symlinks, list):
            raise ValueError(f"`symlinks` must be an array for platform '{platform}'.")
        for s in symlinks:
            if not isinstance(s, dict):
                raise ValueError(f"Each symlink must be an object for platform '{platform}'.")
            enabled = bool(s.get("enabled", True))
            link = str(s.get("link", "")).strip()
            target = str(s.get("target", "")).strip()
            if not enabled:
                if not link:
                    raise ValueError(f"Disabled symlink entry is missing `link` for platform '{platform}'.")
                # Allow target to be empty while disabled (placeholders).
                specs.append(
                    LinkSpec(
                        link=Path(link),
                        target=Path(target) if target else Path("."),
                        platform=platform,
                        enabled=False,
                    )
                )
                continue
            if not link or not target:
                raise ValueError(f"Missing `link` or `target` for platform '{platform}'.")
            specs.append(LinkSpec(link=Path(link), target=Path(target), platform=platform, enabled=True))
    return specs


def _same_path(a: Path, b: Path) -> bool:
    try:
        return a.resolve() == b.resolve()
    except FileNotFoundError:
        # If either doesn't exist, fall back to normalized string comparison.
        return os.path.normpath(str(a)) == os.path.normpath(str(b))


def _ensure_symlink(
    *,
    repo_root: Path,
    spec: LinkSpec,
    dry_run: bool,
    force: bool,
) -> None:
    if not spec.enabled:
        print(f"[SKIP] {spec.platform}: disabled mapping for '{spec.link}'")
        return
    link_abs = (repo_root / spec.link).resolve()
    target_abs = (repo_root / spec.target).resolve()

    if _same_path(link_abs, target_abs):
        print(f"[SKIP] {spec.platform}: '{spec.link}' already equals '{spec.target}'")
        return

    link_parent = link_abs.parent
    if not dry_run:
        link_parent.mkdir(parents=True, exist_ok=True)

    if link_abs.exists() or link_abs.is_symlink():
        if link_abs.is_symlink():
            current = os.readlink(link_abs)
            current_abs = (link_abs.parent / current).resolve()
            if _same_path(current_abs, target_abs):
                print(f"[OK]   {spec.platform}: '{spec.link}' already links to '{spec.target}'")
                return
            if not force:
                raise RuntimeError(
                    f"Refusing to replace symlink '{spec.link}' (currently -> {current}). "
                    f"Re-run with --force to replace."
                )
            print(
                f"[LINK] {spec.platform}: replacing symlink '{spec.link}' "
                f"(was -> {current}) -> '{spec.target}'"
            )
            if not dry_run:
                link_abs.unlink()
        else:
            # Allow replacing an empty directory if --force is set. This makes canonical
            # roots safe to `mkdir -p` early without blocking later symlink adoption.
            if force and link_abs.is_dir():
                if any(link_abs.iterdir()):
                    raise RuntimeError(
                        f"Refusing to overwrite non-empty directory '{spec.link}'. "
                        "Move it out of the way manually."
                    )
                print(f"[LINK] {spec.platform}: replacing empty directory '{spec.link}' with symlink -> '{spec.target}'")
                if not dry_run:
                    link_abs.rmdir()
            else:
                raise RuntimeError(
                    f"Refusing to overwrite non-symlink path '{spec.link}'. "
                    "Move it out of the way manually (or use --force only for empty directories)."
                )

    # Create a relative symlink so it remains stable if the repo is moved.
    rel_target = os.path.relpath(target_abs, start=link_abs.parent)
    print(f"[LINK] {spec.platform}: '{spec.link}' -> '{rel_target}'")
    if not dry_run:
        os.symlink(rel_target, link_abs)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Apply repo-local symlinks based on scripts/platform_paths.json",
    )
    parser.add_argument(
        "--config",
        type=Path,
        default=Path("scripts/platform_paths.json"),
        help="Path to JSON config (default: scripts/platform_paths.json)",
    )
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=None,
        help="Repo root (default: inferred from script location).",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print actions without modifying the filesystem.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Replace existing symlinks if they point somewhere else.",
    )
    args = parser.parse_args()

    repo_root = args.repo_root.resolve() if args.repo_root else _repo_root_from_script_location()
    config_path = (repo_root / args.config).resolve()
    if not config_path.exists():
        raise SystemExit(f"Config not found: {config_path}")

    specs = _load_specs(config_path)
    if not specs:
        print("[OK] No symlinks configured.")
        return 0

    for spec in specs:
        _ensure_symlink(
            repo_root=repo_root,
            spec=spec,
            dry_run=args.dry_run,
            force=args.force,
        )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())


