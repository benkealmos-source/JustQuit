import Foundation

// MARK: - Auth Service Protocol

protocol AuthServiceProtocol {
    var isAuthenticated: Bool { get }
    var currentUserId: String? { get }

    func signIn(email: String, password: String) async throws -> UserProfile
    func signUp(email: String, password: String, displayName: String) async throws -> UserProfile
    func signInWithApple() async throws -> UserProfile
    func signOut() throws
    func deleteAccount() async throws
}

// MARK: - Entitlement Service Protocol

protocol EntitlementServiceProtocol {
    var isPremiumActive: Bool { get async }

    func purchase(product: String) async throws
    func restorePurchases() async throws
    func getCustomerInfo() async throws -> Bool
}

// MARK: - Firestore Service Protocol

protocol FirestoreServiceProtocol {
    func getUser(uid: String) async throws -> UserProfile
    func updateUser(_ user: UserProfile) async throws
    func getQuotes() async throws -> [Quote]
    func getStories() async throws -> [Story]
    func getBoredomContent() async throws -> [BoredomContent]
    func logCheckIn(_ checkIn: CheckIn) async throws
    func logRelapse(_ relapse: Relapse) async throws
    func saveOnboardingResult(_ result: OnboardingResult) async throws
}

// MARK: - AI Generation Service Protocol

protocol AIGenerationServiceProtocol {
    func hasExistingGeneration(userId: String) async throws -> Bool
    func generateFutureSelf(userId: String, imageData: Data) async throws -> FutureSelfResult
    func getExistingResult(userId: String) async throws -> FutureSelfResult?
}

// MARK: - Analytics Service Protocol

protocol AnalyticsServiceProtocol {
    func log(_ event: AnalyticsEvent)
}

enum AnalyticsEvent: String {
    case onboardingStarted = "onboarding_started"
    case onboardingCompleted = "onboarding_completed"
    case resultViewed = "result_viewed"
    case paywallViewed = "paywall_viewed"
    case purchaseStarted = "purchase_started"
    case purchaseCompleted = "purchase_completed"
    case restorePurchasesTapped = "restore_purchases_tapped"
    case homeViewed = "home_viewed"
    case relapseLogged = "relapse_logged"
    case reminderEnabled = "reminder_enabled"
    case aiGenerationStarted = "ai_generation_started"
    case aiGenerationCompleted = "ai_generation_completed"
    case boredTabOpened = "bored_tab_opened"
    case quoteSaved = "quote_saved"
}

// MARK: - Stub implementations for Phase 1

final class StubAnalyticsService: AnalyticsServiceProtocol {
    func log(_ event: AnalyticsEvent) {
        #if DEBUG
        print("[Analytics] \(event.rawValue)")
        #endif
    }
}
