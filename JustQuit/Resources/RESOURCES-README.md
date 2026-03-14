# Resources Folder

This folder holds non-code assets and configuration files for the JustQuit app.

---

## Contents (Phase 1+)

### Assets

| Item | Purpose |
|------|---------|
| `Assets.xcassets` | App icons, launch screen images, in-app images, and color sets. Create via Xcode: File → New → File → Asset Catalog. |
| Custom images | Any PNG/PDF assets used in the UI (e.g., mascot variants, illustrations). |

### Localization

| Item | Purpose |
|------|---------|
| `Localizable.strings` or `JustQuit.xcstrings` | Localized strings for all supported languages. Use `.xcstrings` (Xcode 15+) for String Catalog. |
| `InfoPlist.strings` | Localized Info.plist entries (e.g., permission descriptions). |

### Configuration (Phase 2+)

| Item | Purpose |
|------|---------|
| `GoogleService-Info.plist` | Firebase configuration. Download from Firebase Console; **do not commit** if it contains secrets—use a build-phase script or `.gitignore` for sensitive builds. |
| RevenueCat config | API keys are typically in a plist or build configuration; keep out of version control. |

---

## Setup Notes

- **Phase 1:** The app runs without assets in this folder. You can leave it empty or add `Assets.xcassets` for app icons.
- **Phase 2:** Add `GoogleService-Info.plist` before enabling Firebase in `JustQuitApp.swift`.
- **Localization:** Add `Localizable.strings` or `.xcstrings` when you introduce multiple languages.

---

## Folder Structure (When Populated)

```
Resources/
├── Assets.xcassets/          # App icons, images, colors
├── Localizable.strings       # Or JustQuit.xcstrings
├── GoogleService-Info.plist  # Phase 2 — add to .gitignore if needed
└── RESOURCES-README.md       # This file
```
