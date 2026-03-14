import Foundation

// MARK: - Onboarding Result

struct OnboardingResult: Codable, Identifiable {
    var id: String { "\(userId)_\(completedAt.timeIntervalSince1970)" }
    let userId: String
    let completedAt: Date
    let answers: OnboardingAnswers
    let profile: RecoveryProfile
}

// MARK: - Collected Answers

struct OnboardingAnswers: Codable {
    var ageRange: String
    var gender: String?
    var frequencyOfUse: String
    var commonTriggers: [String]
    var highestRiskTime: String
    var goalsFromQuitting: [String]
    var stressBoredomLoneliness: [String]
    var confidenceLevel: Int
    var reminderPreference: String
}

// MARK: - Computed Recovery Profile

enum RecoveryProfileType: String, Codable, CaseIterable {
    case earlyReset = "Early Reset"
    case habitBreaker = "Habit Breaker"
    case deepRewire = "Deep Rewire"
    case disciplineRebuild = "Discipline Rebuild"

    var summary: String {
        switch self {
        case .earlyReset:
            return "You're catching this early. Based on your answers, you have strong awareness and a solid foundation to build on."
        case .habitBreaker:
            return "You've identified patterns worth changing. Users with similar profiles often report meaningful shifts within a few weeks of consistent effort."
        case .deepRewire:
            return "This goes deeper than surface habits. Your answers suggest a journey of real internal rewiring — which is exactly what this app is built for."
        case .disciplineRebuild:
            return "Rebuilding discipline is one of the most empowering things you can do. Based on your answers, structured daily commitments will be your greatest tool."
        }
    }

    var estimatedMilestoneWindow: String {
        switch self {
        case .earlyReset: return "First noticeable changes often within 1–2 weeks"
        case .habitBreaker: return "Meaningful shift often reported around 2–4 weeks"
        case .deepRewire: return "Deeper changes typically emerge around 4–8 weeks"
        case .disciplineRebuild: return "Users often report new momentum after 3–6 weeks"
        }
    }

    var topImprovements: [String] {
        switch self {
        case .earlyReset:
            return ["Sharper focus", "Better sleep quality", "Increased motivation"]
        case .habitBreaker:
            return ["Improved self-control", "Reduced brain fog", "More emotional stability"]
        case .deepRewire:
            return ["Restored confidence", "Healthier relationships", "Sustained energy levels"]
        case .disciplineRebuild:
            return ["Stronger willpower", "Daily routine consistency", "Renewed self-respect"]
        }
    }
}

struct RecoveryProfile: Codable {
    let type: RecoveryProfileType
    let estimatedMilestoneWindow: String
    let topImprovements: [String]

    static func compute(from answers: OnboardingAnswers) -> RecoveryProfile {
        let frequency = answers.frequencyOfUse.lowercased()
        let confidence = answers.confidenceLevel
        let triggerCount = answers.commonTriggers.count

        let type: RecoveryProfileType
        if confidence >= 7 && triggerCount <= 2 {
            type = .earlyReset
        } else if frequency.contains("daily") || triggerCount >= 4 {
            type = .deepRewire
        } else if confidence <= 3 {
            type = .disciplineRebuild
        } else {
            type = .habitBreaker
        }

        return RecoveryProfile(
            type: type,
            estimatedMilestoneWindow: type.estimatedMilestoneWindow,
            topImprovements: type.topImprovements
        )
    }
}
