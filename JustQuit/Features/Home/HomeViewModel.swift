import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var userProfile: UserProfile
    @Published var dailyQuote: Quote
    @Published var weeklyDays: [DayStatus]
    @Published var showPanicSheet: Bool = false

    var streakDays: Int { userProfile.currentStreakDays }
    var longestStreak: Int { userProfile.longestStreak }
    var relapseCount: Int { userProfile.relapseCount }

    var streakTier: StreakTier { StreakTier(days: streakDays) }

    var motivationalMessage: String {
        switch streakTier {
        case .nascent:
            return "Every journey begins with a single step. Start yours now."
        case .awakening:
            return "You've taken the first steps. Keep building momentum."
        case .building:
            return "You're building real discipline. Your brain is rewiring."
        case .ascending:
            return "Impressive commitment. You're becoming who you want to be."
        case .transcendent:
            return "Extraordinary discipline. You are in full control."
        }
    }

    var rewireProgress: Double {
        min(1.0, Double(streakDays) / 90.0)
    }

    var rewireLabel: String {
        let percentage = Int(rewireProgress * 100)
        return "\(percentage)% estimated rewiring progress"
    }

    init(userProfile: UserProfile = MockData.user) {
        self.userProfile = userProfile
        self.dailyQuote = MockData.dailyQuote
        self.weeklyDays = MockData.weeklyCheckIns()
    }

    func logRelapse() {
        userProfile.relapseCount += 1
        userProfile.currentStreakStart = .now
        weeklyDays = MockData.weeklyCheckIns()
    }

    func checkIn() {
        userProfile.lastCheckInAt = .now
    }
}
