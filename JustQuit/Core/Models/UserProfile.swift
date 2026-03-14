import Foundation

struct UserProfile: Codable, Identifiable {
    var id: String { uid }
    let uid: String
    var email: String
    var displayName: String
    var createdAt: Date
    var onboardingCompleted: Bool
    var selectedGoals: [String]
    var currentStreakStart: Date?
    var longestStreak: Int
    var relapseCount: Int
    var lastCheckInAt: Date?
    var reminderSettings: ReminderSettings

    var currentStreakDays: Int {
        guard let start = currentStreakStart else { return 0 }
        return max(0, Calendar.current.dateComponents([.day], from: start, to: .now).day ?? 0)
    }

    static let empty = UserProfile(
        uid: "",
        email: "",
        displayName: "",
        createdAt: .now,
        onboardingCompleted: false,
        selectedGoals: [],
        currentStreakStart: nil,
        longestStreak: 0,
        relapseCount: 0,
        lastCheckInAt: nil,
        reminderSettings: .default
    )
}
