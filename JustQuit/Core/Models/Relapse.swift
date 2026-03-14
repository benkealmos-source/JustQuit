import Foundation

struct Relapse: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    let trigger: String?
    let note: String?
    let previousStreakDays: Int
}
