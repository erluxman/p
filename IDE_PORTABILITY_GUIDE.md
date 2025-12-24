# IDE Portability Guide

**Purpose**: Making your AI development rules and guidelines portable across different IDEs/editors

---

## The Problem

If you use Cursor-specific configurations (like `.cursor/rules/` or `.cursorrules`), you're locked into Cursor IDE. This guide shows how to make your guidelines portable.

---

## What's IDE-Specific vs Portable

### ❌ IDE-Specific (Locked to Cursor)

- **`.cursor/rules/`** - Cursor's new rule system (`.mdc` files)
- **`.cursorrules`** - Cursor's legacy rule format
- **`.cursor/mcp.json`** - Cursor's MCP configuration
- **`.cursor/context.md`** - Cursor's context file

### ✅ Portable (Works Everywhere)

- **`project_constitution.md`** - Architecture guidelines (IDE-agnostic)
- **`workflow_protocol.md`** - Development workflow (IDE-agnostic)
- **`promotsamples.md`** - Prompt templates (can be adapted)
- **`testing_strategy.md`** - Testing guidelines (IDE-agnostic)
- **`common_mistakes.md`** - Anti-patterns (IDE-agnostic)

---

## Portability Strategy

### Strategy 1: Portable Markdown Files (Recommended)

**Keep all guidelines in portable markdown files**, then create IDE-specific wrappers that reference them.

```text
project-root/
├── docs/                           # Portable documentation
│   ├── architecture.md            # Architecture guidelines
│   ├── coding_standards.md        # Coding standards
│   ├── testing_guidelines.md       # Testing strategy
│   ├── workflow.md                 # Development workflow
│   └── common_mistakes.md          # Anti-patterns
│
├── .cursorrules                    # Cursor: References docs/
├── .cursor/rules/                  # Cursor: References docs/
│   └── core_rules.mdc
│
├── .github/                        # GitHub Copilot: References docs/
│   └── copilot-instructions.md
│
└── .codeium/                       # Codeium: References docs/
    └── instructions.md
```

**Benefits:**

- ✅ Single source of truth
- ✅ Works with any IDE
- ✅ Easy to maintain
- ✅ Version-controlled

### Strategy 2: “Rules as Thin Shims” + Topic-Scoped Modules (Best for signal)

Even within one platform (e.g., Flutter), split rules by **concern** so the IDE only loads relevant constraints:

- **Platform**: flutter / react / backend
- **Layer**: domain / application / infrastructure / presentation
- **Concern**: state (bloc/riverpod), networking, auth, animations, accessibility, testing

This improves compliance because the model sees fewer, more relevant constraints at a time.

---

## IDE-Specific Implementations

### Cursor

**`.cursorrules`** (Legacy format):

```markdown
# AI Agent Rules

**Reference**: See `docs/` directory for complete guidelines.

## Quick Reference

- Architecture: See `project_constitution.md`
- Workflow: See `workflow_protocol.md`
- Testing: See `docs/testing_guidelines.md`
- Common Mistakes: See `docs/common_mistakes.md`

## Cursor-Specific

- Always reference @project_constitution.md @workflow_protocol.md
- Use TDD approach (tests first)
- Follow Hexagonal Architecture
```

**`.cursor/rules/core_rules.mdc`**:

```markdown
# Core Development Rules

See `docs/coding_standards.md` for complete guidelines.

## Key Principles

1. Test-Driven Development (mandatory)
2. Hexagonal Architecture compliance
3. Atomic changes (1-3 files max)
4. No business logic in UI

## Reference Files

- @project_constitution.md
- @workflow_protocol.md
- @docs/testing_guidelines.md
```

**Topic-scoped `.mdc` (recommended):**

```text
.cursor/rules/
  core/
    00_core.mdc
    10_workflow.mdc
    20_security.mdc
  flutter/
    bloc.mdc          # scoped to state management paths
    animations.mdc    # scoped to animation paths
    auth.mdc          # scoped to auth paths
```

Rule selection is then driven by **globs** inside each `.mdc`, so working on BLoC does not pull in animations/auth instructions.

### GitHub Copilot

**`.github/copilot-instructions.md`**:

```markdown
# Copilot Instructions

**Reference**: See `docs/` directory for complete guidelines.

## Architecture

Follow Hexagonal Architecture as defined in `project_constitution.md`.

## Workflow

Follow the 5-stage workflow in `workflow_protocol.md`:

1. Spec → 2. Critique → 3. Plan → 4. Execute → 5. Verify

## Testing

Mandatory test-first approach. See `docs/testing_guidelines.md`.

## Key Rules

- Tests before code
- Atomic changes only
- No business logic in UI
- Follow dependency rule (inward only)
```

### Codeium

**`.codeium/instructions.md`**:

```markdown
# Codeium Instructions

**Reference**: See `docs/` directory for complete guidelines.

## Development Principles

- Test-Driven Development (mandatory)
- Hexagonal Architecture
- Atomic changes
- Comprehensive error handling

See `project_constitution.md` and `workflow_protocol.md` for details.
```

### Continue.dev

**`.continue/config.json`**:

```json
{
  "rules": [
    "Follow Hexagonal Architecture (see project_constitution.md)",
    "Test-first development (see docs/testing_guidelines.md)",
    "Atomic changes only (1-3 files max)",
    "Reference workflow_protocol.md for development process"
  ],
  "context": [
    "project_constitution.md",
    "workflow_protocol.md",
    "docs/coding_standards.md"
  ]
}
```

### Aider

**`.aiderignore`** + **`.aiderchat.md`**:

```markdown
# Aider Chat Instructions

Reference `project_constitution.md` and `workflow_protocol.md` for guidelines.

Key principles:

- Test-first development
- Hexagonal Architecture
- Atomic changes
```

---

## Recommended File Structure

### Option A: Centralized Docs (Best for Portability)

```text
project-root/
├── docs/                           # All portable guidelines
│   ├── architecture/
│   │   ├── hexagonal_architecture.md
│   │   └── directory_structure.md
│   ├── development/
│   │   ├── workflow.md
│   │   ├── coding_standards.md
│   │   └── testing_guidelines.md
│   ├── platform/
│   │   ├── flutter_guidelines.md
│   │   ├── react_guidelines.md
│   │   └── backend_guidelines.md
│   └── common_mistakes.md
│
├── project_constitution.md         # Main reference (portable)
├── workflow_protocol.md            # Main workflow (portable)
│
├── .cursorrules                    # Cursor: Thin wrapper
├── .cursor/rules/                  # Cursor: References docs/
├── .github/copilot-instructions.md # GitHub Copilot
├── .codeium/instructions.md        # Codeium
└── .continue/config.json           # Continue.dev
```

### Option B: Current Structure (Simpler)

```text
project-root/
├── project_constitution.md         # Portable
├── workflow_protocol.md            # Portable
├── promotsamples.md                # Portable (with minor edits)
│
├── .cursorrules                    # Cursor-specific wrapper
└── .cursor/rules/                  # Cursor-specific (references above)

**Note:** even in Option B, you can still split `.cursor/rules/` into subfolders by platform and concern to avoid irrelevant rule loading.
```

---

## Migration Path

### If You're Currently Using Cursor

1. **Keep your portable files** (they're already portable!):

   - `project_constitution.md` ✅
   - `workflow_protocol.md` ✅
   - `promotsamples.md` ✅ (mostly portable)

2. **Make `.cursorrules` a thin wrapper**:

   - Reference the portable files
   - Add only Cursor-specific syntax

3. **Create IDE-specific files as needed**:
   - When switching to another IDE, create its config file
   - Reference the same portable files

### Example: Thin Wrapper Approach

**`.cursorrules`** (Thin wrapper):

```markdown
# AI Agent Rules

**IMPORTANT**: This file references portable guidelines. The actual rules are in:

- `project_constitution.md` - Architecture and principles
- `workflow_protocol.md` - Development workflow
- `promotsamples.md` - Prompt templates

## Cursor-Specific Instructions

- Always start prompts with: `@project_constitution.md @workflow_protocol.md`
- Use `@filename` syntax to reference files
- Follow the 5-stage workflow in `workflow_protocol.md`

## Quick Reference

### Architecture

- Hexagonal Architecture (see `project_constitution.md`)
- Dependency rule: Dependencies point inward only

### Workflow

1. Spec → 2. Critique → 3. Plan → 4. Execute → 5. Verify (see `workflow_protocol.md` for details)

### Testing

- Tests are mandatory for every change
- Test-first approach
- Coverage requirements: Domain 100%, Application 80%, etc.

### Common Mistakes

- Large feature drops (break into increments)
- Skipping overview phase
- Assuming AI understanding (always verify)
- Overreliance on AI (always review code)

For complete guidelines, see the referenced files above.
```

---

## Cross-IDE Compatibility Matrix

| Feature | Cursor | GitHub Copilot | Codeium | Continue.dev | Aider |
| --- | --- | --- | --- | --- | --- |
| Markdown rules | ✅ `.cursorrules` | ✅ `.github/copilot-instructions.md` | ✅ `.codeium/instructions.md` | ✅ `.continue/config.json` | ✅ `.aiderchat.md` |
| File references | ✅ `@filename` | ✅ `@filename` | ✅ `@filename` | ✅ Context array | ⚠️ Limited |
| Directory rules | ✅ `.cursor/rules/` | ❌ | ❌ | ✅ | ❌ |
| MCP integration | ✅ | ❌ | ❌ | ❌ | ❌ |

---

## Best Practices for Portability

### ✅ DO

1. **Keep core guidelines in portable markdown files**

   - `project_constitution.md`
   - `workflow_protocol.md`
   - `docs/` directory for detailed guidelines

2. **Make IDE configs thin wrappers**

   - Reference portable files
   - Add only IDE-specific syntax

3. **Use relative paths**

   - `@project_constitution.md` (not absolute paths)
   - Works across different machines

4. **Version control everything**
   - Include portable files in git
   - IDE-specific configs can be optional

### ❌ DON'T

1. **Don't put core rules in IDE-specific files**

   - Avoid: Putting architecture rules only in `.cursorrules`
   - Better: Put in `project_constitution.md`, reference from `.cursorrules`

2. **Don't duplicate content**

   - Single source of truth
   - Reference, don't copy

3. **Don't use IDE-specific syntax in portable files**
   - Avoid: Cursor's `@filename` in `project_constitution.md`
   - Better: Use standard markdown, let IDE configs add syntax

---

## Migration Checklist

When switching IDEs:

- [ ] Identify portable files (already done ✅)
- [ ] Create IDE-specific config file
- [ ] Reference portable files from IDE config
- [ ] Test that AI can access referenced files
- [ ] Update team documentation
- [ ] Remove old IDE-specific files (optional)

---

## Example: Switching from Cursor to GitHub Copilot

### Step 1: Identify Portable Files

```text
✅ project_constitution.md (portable)
✅ workflow_protocol.md (portable)
✅ promotsamples.md (mostly portable)
```

### Step 2: Create Copilot Config

Create `.github/copilot-instructions.md`:

```markdown
# Copilot Instructions

Reference these files for complete guidelines:

- `project_constitution.md` - Architecture and principles
- `workflow_protocol.md` - Development workflow

## Key Rules

[Copy thin wrapper content from .cursorrules]
```

### Step 3: Test

- Verify Copilot can access referenced files
- Test that guidelines are followed

### Step 4: Optional Cleanup

- Keep `.cursorrules` if you might switch back
- Or remove it if permanently switching

---

## Current Project Status

### ✅ Already Portable

- `project_constitution.md` - Works with any IDE
- `workflow_protocol.md` - Works with any IDE
- `promotsamples.md` - Works with any IDE (minor syntax differences)

### ⚠️ Cursor-Specific

- `.cursorrules` - Only works with Cursor
- `.cursor/rules/` (if created) - Only works with Cursor

### 💡 Recommendation

Make `.cursorrules` a thin wrapper that references the portable files. This way:

- ✅ You can switch IDEs easily
- ✅ Single source of truth
- ✅ Easy to maintain

---

## Quick Reference: IDE Config Files

| IDE | Config File | Format | Notes |
| --- | --- | --- | --- |
| Cursor | `.cursorrules` | Markdown | Legacy format |
| Cursor | `.cursor/rules/*.mdc` | Markdown | New format |
| GitHub Copilot | `.github/copilot-instructions.md` | Markdown | In repo root or .github/ |
| Codeium | `.codeium/instructions.md` | Markdown | In repo root |
| Continue.dev | `.continue/config.json` | JSON | In repo root |
| Aider | `.aiderchat.md` | Markdown | In repo root |

---

**Bottom Line**: Your core guidelines (`project_constitution.md`, `workflow_protocol.md`) are already portable! Just make `.cursorrules` a thin wrapper that references them, and you can switch IDEs anytime.
