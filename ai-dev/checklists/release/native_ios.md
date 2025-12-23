# Release Checklist: Native iOS

## Build & smoke

- Release build succeeds from `apps/ios/` (Xcode build/archive).
- App launches and critical flows work on device/simulator.

## Versioning

- Build number and version updated appropriately.

## Signing

- Signing/provisioning correct for release environment (no secrets committed).

## Privacy / permissions

- Privacy strings (Info.plist) updated for any new permissions.
- Permission prompts tested (allow + deny).
