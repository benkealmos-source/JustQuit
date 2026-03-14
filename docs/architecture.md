# JustQuit Architecture

## Overview

JustQuit follows a modular MVVM architecture with SwiftUI, designed for production-scale iOS development with Firebase and RevenueCat.

## Architecture Layers

```
┌──────────────────────────────────────────────────────────────┐
│                        UI Layer                               │
│  SwiftUI Views → ViewModels (ObservableObject, @MainActor)   │
├──────────────────────────────────────────────────────────────┤
│                     Service Layer                             │
│  Protocol-based services injected via EnvironmentObject       │
│  AuthService | FirestoreService | EntitlementService          │
│  AnalyticsService | AIGenerationService                       │
├──────────────────────────────────────────────────────────────┤
│                    External SDKs                              │
│  Firebase Auth | Firestore | Storage | Cloud Functions        │
│  RevenueCat | Firebase Analytics | Crashlytics                │
└──────────────────────────────────────────────────────────────┘
```

## Routing

A single `AppState` object (ObservableObject, @MainActor) drives all navigation:

- `authState` — `.unauthenticated` | `.authenticated`
- `onboardingState` — `.notStarted` | `.quiz` | `.result` | `.complete`
- `entitlementState` — `.unknown` | `.active` | `.inactive`

`AppRouter` reads `appState.currentRoute` (computed property) and switches between:
1. `LaunchView`
2. `OnboardingQuizView`
3. `ResultView`
4. `PaywallView`
5. `AuthView`
6. `MainTabView` (only if authenticated + premium active)

## Feature Modules

Each feature lives in its own folder under `Features/`:

```
Features/
├── Home/
│   ├── HomeView.swift
│   ├── HomeViewModel.swift
│   └── Components/
│       ├── DailyQuoteCard.swift
│       ├── QuickActionCard.swift
│       ├── ProgressCard.swift
│       └── WeeklyStreakIndicator.swift
├── Onboarding/
│   └── OnboardingQuizView.swift
...
```

ViewModels are `@MainActor final class`es with `@Published` state.

## Design System

Centralized tokens ensure visual consistency:

| File | Purpose |
|------|---------|
| `Colors.swift` | All color constants (backgrounds, accents, text, glow) |
| `Typography.swift` | Font presets (display, title, body, number, button, chip) |
| `Spacing.swift` | Spacing scale, corner radii, shadow/glow utilities |
| `Theme.swift` | Semantic aliases, glass background modifier, starfield |

Reusable components: `GlassCard`, `PrimaryButton`, `SecondaryButton`, `ChipButton`, `OnboardingProgressBar`, `ProgressRing`, `FlowLayout`, `MascotStreakView`.

## Mascot System

The mascot is an orb/guardian rendered entirely in SwiftUI:

- **Base:** `Circle` with `RadialGradient` + glass highlight
- **Aura:** Concentric rings with `AngularGradient` + `RadialGradient`
- **Dynamic:** Streak number overlaid as `Text`; glow color, intensity, and core color driven by `StreakTier`
- **Animation:** Gentle breathing (`scaleEffect`) + slow aura rotation; disabled when Reduce Motion is on

### Streak Tiers

| Tier | Days | Core Color | Glow | Intensity |
|------|------|-----------|------|-----------|
| Nascent | 0 | Dark blue | Dim blue | 0.15 |
| Awakening | 1–3 | Blue | Blue | 0.25 |
| Building | 4–14 | Bright blue | Cyan | 0.35 |
| Ascending | 15–29 | Sky blue | Cyan | 0.45 |
| Transcendent | 30+ | Gold | Gold | 0.55 |

## Data Model

### Core Models

- `UserProfile` — user state, streak, goals, reminder settings
- `OnboardingResult` — quiz answers + computed `RecoveryProfile`
- `Quote`, `Story`, `BoredomContent` — content models (remotely configurable)
- `CheckIn`, `Relapse` — tracking events
- `AIGeneration` — future self generation record
- `SoftCategory` — illustrative motivational categories (non-clinical)

### Recovery Profiles

Computed from onboarding answers (frequency, trigger count, confidence):
1. Early Reset
2. Habit Breaker
3. Deep Rewire
4. Discipline Rebuild

Each includes summary, estimated milestone window, and top improvements — all labeled as illustrative / based on user answers.

## Security Model (Phase 2)

- Firestore rules: user can only read/write own docs
- `ai_generations`: read-only for client; writes only via Cloud Function
- `premium_access` / `aiGenerationUsed`: never client-writable
- Storage: auth required, path-matched to userId, MIME/size validation
- App Check: enforced on Cloud Functions

## Entitlement Gating

RevenueCat entitlement `premium_access` gates all main app features.

- Onboarding quiz and result preview are free
- Main tab bar only accessible with active entitlement
- Checked via `AppState.shouldShowMainApp`
- Phase 1 uses mock flags; Phase 2 integrates RevenueCat SDK

## Analytics Events

All events defined as `AnalyticsEvent` enum, logged via `AnalyticsServiceProtocol`.
Phase 1 uses `StubAnalyticsService` (prints to console in DEBUG).

## Accessibility

- `@Environment(\.accessibilityReduceMotion)` respected for all animations
- `accessibilityLabel` on interactive elements
- Dynamic Type supported via `Font.system(...)` with semantic sizing
- Minimum 44pt tap targets
- High contrast dark theme (white text on deep navy)
