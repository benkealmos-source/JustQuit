import Foundation

struct CheckIn: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    let mood: Mood?
    let note: String?
    let urgeLevel: Int?

    enum Mood: String, Codable, CaseIterable {
        case great
        case good
        case neutral
        case struggling
        case tough

        var emoji: String {
            switch self {
            case .great: return "🌟"
            case .good: return "😊"
            case .neutral: return "😐"
            case .struggling: return "😓"
            case .tough: return "💪"
            }
        }

        var label: String {
            rawValue.capitalized
        }
    }
}
