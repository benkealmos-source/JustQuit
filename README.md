# JustQuit

A premium native iOS habit-change app that helps users reduce compulsive behaviors through streak tracking, motivational content, urge interruption tools, and an AI-powered "Future Self" visualization.

**This is a wellness/habit-change app — not a medical app.**

## Tech Stack

- **Platform:** iOS 17+
- **Language:** Swift
- **UI:** SwiftUI
- **Architecture:** MVVM + protocols + dependency injection
- **Backend:** Firebase (Auth, Firestore, Storage, Cloud Functions, Cloud Messaging, Analytics, Crashlytics, App Check)
- **Purchases:** RevenueCat (`premium_access` entitlement)

## Project Structure

```
JustQuit/
├── JustQuit/
│   ├── App/                  # App entry point, AppState
│   ├── DesignSystem/         # Theme tokens, reusable components
│   │   └── Components/       # GlassCard, PrimaryButton, MascotStreakView, etc.
│   ├── Features/             # Feature modules (one folder per screen)
│   │   ├── Home/
│   │   ├── Onboarding/
│   │   ├── Paywall/
│   │   ├── Auth/
│   │   ├── StoriesQuotes/
│   │   ├── FutureSelf/
│   │   ├── StreakReminders/
│   │   ├── BoredPanic/
│   │   └── Settings/
│   ├── Core/
│   │   ├── Models/           # Data models (Codable)
│   │   ├── Services/         # Service protocols + mock implementations
│   │   ├── Routing/          # AppRouter, MainTabView
│   │   └── Extensions/       # View + Date extensions
│   └── Resources/            # Assets, localization
├── functions/                # Firebase Cloud Functions (Phase 2+)
├── firestore.rules           # Firestore security rules (Phase 2+)
├── storage.rules             # Storage security rules (Phase 2+)
├── docs/
│   └── architecture.md       # Architecture documentation
└── README.md
```

## Setup Instructions

### Prerequisites

- Xcode 15+ (macOS)
- Apple Developer Account (for device testing & App Store)
- Firebase project (Blaze plan)
- RevenueCat account

### Step 1: Create Xcode Project

1. Open Xcode → File → New → Project
2. Choose "App" under iOS
3. Product Name: **JustQuit**
4. Interface: **SwiftUI**
5. Language: **Swift**
6. Minimum Deployment: **iOS 17.0**
7. Save into the `JustQuit/` folder (so `JustQuit.xcodeproj` sits alongside the `JustQuit/` source folder)
8. Delete the auto-generated `ContentView.swift` and `JustQuitApp.swift`
9. Add all files from `JustQuit/` source folder to the project

### Step 2: Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Add an iOS app with your bundle identifier
4. Download `GoogleService-Info.plist` and add it to the Xcode project
5. Enable these services:
   - Authentication (Email/Password + Apple Sign In + Google Sign In)
   - Cloud Firestore
   - Firebase Storage
   - Cloud Messaging
   - Analytics
   - Crashlytics
   - App Check
6. Add Firebase SDK via Swift Package Manager:
   - `https://github.com/firebase/firebase-ios-sdk`
   - Select: FirebaseAuth, FirebaseFirestore, FirebaseStorage, FirebaseMessaging, FirebaseAnalytics, FirebaseCrashlytics, FirebaseAppCheck

### Step 3: RevenueCat Setup

1. Go to [RevenueCat Dashboard](https://app.revenuecat.com)
2. Create a new project
3. Create entitlement: `premium_access`
4. Create products:
   - Monthly: $9.99/mo (with intro offer: $9.99 for first 3 months)
   - Yearly: $49.99/yr
   - Lifetime: $99.99
5. Add RevenueCat SDK via SPM:
   - `https://github.com/RevenueCat/purchases-ios`
6. Configure API key (do NOT commit to git — use build config or .plist)

### Step 4: Uncomment Firebase/RevenueCat Init

In `JustQuitApp.swift`, uncomment and configure:
- `FirebaseApp.configure()`
- `Purchases.configure(withAPIKey:)`
- Crashlytics initialization

## Current Status

### Phase 1 (Complete)
- Design system (colors, typography, spacing, glass cards, buttons)
- Mascot-based streak centerpiece with dynamic glow/aura/tier system
- Full app shell with routing (Launch → Onboarding → Result → Paywall → Auth → Main)
- 6-tab main app (Home, Stories, Future Self, Streak, SOS, Settings)
- Complete Home screen with mock data
- Onboarding quiz with 8 steps
- Paywall with 3 plan options
- All placeholder screens functional with mock data

### Phase 2 (Planned)
- Firebase Auth integration
- Firestore data persistence
- RevenueCat purchase flow
- Cloud Functions (AI Future Self, RevenueCat webhook)
- Firestore + Storage security rules
- Push notifications
- Analytics + Crashlytics

## Content Guidelines

- No fake testimonials or press logos
- Stories labeled as "Illustrative" or "Community-Inspired"
- No medical claims or diagnostic language
- Milestone windows described as "estimated" and "based on your answers"
- AI results described as "illustrative" with clear disclaimers
- No explicit, shame-based, or humiliating language

## License

Proprietary. All rights reserved.
