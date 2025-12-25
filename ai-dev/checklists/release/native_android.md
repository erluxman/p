# Release Checklist: Native Android

## Build & smoke

- Release build succeeds from `apps/mobile/android/`:
  - `./gradlew assembleRelease` (or equivalent)
- App launches and critical flows work on device/emulator.

## Versioning

- `versionCode` and `versionName` updated appropriately.

## Signing

- Signing config is correct for the release environment (no secrets committed).

## Permissions

- Any new permissions reviewed and justified.
- Permission prompts tested (allow + deny).
