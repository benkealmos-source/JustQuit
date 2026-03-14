import SwiftUI

// MARK: - App-wide State

@MainActor
final class AppState: ObservableObject {

    // MARK: Auth

    enum AuthState: Equatable {
        case unauthenticated
        case authenticated
    }

    // MARK: Onboarding

    enum OnboardingState: Equatable {
        case notStarted
        case quiz
        case result
        case complete
    }

    // MARK: Entitlement

    enum EntitlementState: Equatable {
        case unknown
        case active
        case inactive
    }

    // MARK: Published State

    @Published var authState: AuthState = .unauthenticated
    @Published var onboardingState: OnboardingState = .notStarted
    @Published var entitlementState: EntitlementState = .unknown
    @Published var currentTab: AppTab = .home
    @Published var userProfile: UserProfile = .empty

    var shouldShowMainApp: Bool {
        authState == .authenticated && entitlementState == .active
    }

    var currentRoute: AppRoute {
        if shouldShowMainApp && onboardingState == .complete {
            return .main
        }

        switch onboardingState {
        case .notStarted:
            return .launch
        case .quiz:
            return .onboarding
        case .result:
            return .result
        case .complete:
            if entitlementState != .active {
                return .paywall
            }
            if authState != .authenticated {
                return .auth
            }
            return .main
        }
    }

    // MARK: - Mock helpers (Phase 1 only)

    func mockCompleteOnboarding() {
        onboardingState = .complete
    }

    func mockAuthenticate() {
        authState = .authenticated
        userProfile = MockData.user
    }

    func mockActivatePremium() {
        entitlementState = .active
    }

    func mockFullAccess() {
        onboardingState = .complete
        authState = .authenticated
        entitlementState = .active
        userProfile = MockData.user
    }

    func mockSignOut() {
        authState = .unauthenticated
        entitlementState = .unknown
        onboardingState = .notStarted
        userProfile = .empty
        currentTab = .home
    }
}

// MARK: - Tab Enum

enum AppTab: String, CaseIterable, Identifiable {
    case home
    case stories
    case futureSelf
    case streak
    case bored
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .stories: return "Stories"
        case .futureSelf: return "Future Self"
        case .streak: return "Streak"
        case .bored: return "SOS"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .stories: return "book.fill"
        case .futureSelf: return "sparkles"
        case .streak: return "flame.fill"
        case .bored: return "exclamationmark.shield.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

// MARK: - Route Enum

enum AppRoute: Equatable {
    case launch
    case onboarding
    case result
    case paywall
    case auth
    case main
}
