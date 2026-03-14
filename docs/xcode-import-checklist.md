# JustQuit — Xcode Import Checklist

Use this checklist when importing the JustQuit source into a new Xcode project.

---

## 1. Source Folder Location

**Exact path to the folder containing all Swift source files:**

```
JustQuit/JustQuit/
```

Full path (adjust for your machine):

```
<project-root>/JustQuit/JustQuit/
```

This folder contains:
- `App/`
- `DesignSystem/`
- `Features/`
- `Core/`

---

## 2. Files to Delete from a New Xcode App Project

After creating a new iOS App project named **JustQuit**, Xcode generates boilerplate files. Delete these **before** adding the source:

| File | Reason |
|------|--------|
| `ContentView.swift` | Replaced by feature views; app uses `AppRouter` as root |
| `JustQuitApp.swift` | Replaced by project’s own `JustQuitApp.swift` in `App/` |

**How to delete:** Right‑click each file in the Project Navigator → Delete → Move to Trash (or Remove Reference if you prefer to keep files on disk).

---

## 3. Folder to Add to Xcode

**Drag this folder into the Xcode project:**

```
JustQuit/JustQuit/
```

**Steps:**
1. In Xcode, right‑click the **JustQuit** group (the blue project group) in the Project Navigator.
2. Choose **Add Files to "JustQuit"...**
3. Navigate to and select the `JustQuit` folder (the inner one containing `App`, `DesignSystem`, `Features`, `Core`).
4. In the dialog:
   - **Copy items if needed:** Uncheck (files already live in the project directory).
   - **Added folders:** Select **Create groups**.
   - **Add to targets:** Ensure **JustQuit** is checked.
5. Click **Add**.

**Alternative:** Drag the `JustQuit` folder from Finder into the Xcode Project Navigator, then choose **Create groups** and **JustQuit** target.

---

## 4. Expected Final Structure

After setup, the project root should look like this:

```
JustQuit/                          ← Project root (parent of .xcodeproj)
├── JustQuit.xcodeproj/            ← Xcode project file
├── JustQuit/                      ← Source folder (dragged into Xcode)
│   ├── App/
│   │   ├── AppState.swift
│   │   └── JustQuitApp.swift
│   ├── DesignSystem/
│   │   ├── Colors.swift
│   │   ├── Spacing.swift
│   │   ├── Theme.swift
│   │   ├── Typography.swift
│   │   └── Components/
│   │       ├── ChipButton.swift
│   │       ├── GlassCard.swift
│   │       ├── MascotStreakView.swift
│   │       ├── PrimaryButton.swift
│   │       ├── ProgressIndicator.swift
│   │       └── SecondaryButton.swift
│   ├── Features/
│   │   ├── Auth/
│   │   ├── BoredPanic/
│   │   ├── FutureSelf/
│   │   ├── Home/
│   │   ├── Launch/
│   │   ├── Onboarding/
│   │   ├── Paywall/
│   │   ├── Result/
│   │   ├── Settings/
│   │   ├── StoriesQuotes/
│   │   └── StreakReminders/
│   ├── Core/
│   │   ├── Models/
│   │   ├── Services/
│   │   ├── Routing/
│   │   └── Extensions/
│   └── Resources/
├── docs/
├── functions/                     ← Phase 2+
├── firestore.rules                ← Phase 2+
├── storage.rules                  ← Phase 2+
└── README.md
```

**Important:** `JustQuit.xcodeproj` must sit **alongside** the inner `JustQuit/` source folder, not inside it.

---

## 5. Likely Import / Build Issues to Check First

### Before First Build

| Check | Action |
|-------|--------|
| **App entry point** | Ensure `JustQuitApp.swift` has `@main` and is the only file with `@main`. Remove it from any auto-generated duplicate. |
| **Target membership** | Confirm all 43 Swift files are in the **JustQuit** target (File Inspector → Target Membership). |
| **iOS deployment** | Set minimum deployment target to **iOS 17.0** (Project → JustQuit → General → Minimum Deployments). |

### Phase 1 (No Firebase / RevenueCat)

The app uses mock services and should build **without** Firebase or RevenueCat. If you see:

- `FirebaseApp` / `Purchases` — These are commented out in `JustQuitApp.swift` for Phase 1. Leave them commented until Phase 2.
- Missing `GoogleService-Info.plist` — Not required for Phase 1; add in Phase 2.

### Phase 2 (Firebase / RevenueCat)

| Issue | Fix |
|-------|-----|
| **Firebase not found** | Add Firebase SDK via SPM: `https://github.com/firebase/firebase-ios-sdk`. Select: Auth, Firestore, Storage, Messaging, Analytics, Crashlytics, AppCheck. |
| **RevenueCat not found** | Add via SPM: `https://github.com/RevenueCat/purchases-ios`. |
| **GoogleService-Info.plist missing** | Download from Firebase Console, add to project (typically in `Resources/` or project root). |
| **Crash on launch** | Uncomment `FirebaseApp.configure()` in `JustQuitApp.swift` only after adding `GoogleService-Info.plist`. |
| **Purchases crash** | Uncomment `Purchases.configure(withAPIKey:)` only after adding RevenueCat API key via build config or plist. |

### Common Swift / Xcode Issues

| Issue | Fix |
|-------|-----|
| **Duplicate symbol errors** | Ensure the old `ContentView.swift` and generated `JustQuitApp.swift` were deleted. |
| **"No such module"** | Clean build folder (Product → Clean Build Folder), then build again. |
| **Preview crashes** | Some previews may fail without Firebase; use a simulator or device for testing. |
| **Dark mode** | App forces dark appearance; check `Info.plist` or `JustQuitApp.swift` for `preferredColorScheme(.dark)`. |

### File References

| Issue | Fix |
|-------|-----|
| **Red/missing files** | Re-add the `JustQuit` folder with "Create groups" so Xcode creates proper group references. |
| **Wrong folder structure** | Use **Create groups**, not **Create folder references**, so Swift files compile. |

---

## Quick Reference

| Step | Action |
|------|--------|
| 1 | Create new iOS App project: JustQuit, SwiftUI, Swift, iOS 17.0 |
| 2 | Save into `JustQuit/` so `.xcodeproj` sits next to source folder |
| 3 | Delete `ContentView.swift` and `JustQuitApp.swift` |
| 4 | Add `JustQuit/JustQuit/` folder → Create groups, JustQuit target |
| 5 | Build (⌘B) — should succeed with mock services |
| 6 | Run on simulator — full flow works without Firebase/RevenueCat |
