import Foundation

struct Quote: Codable, Identifiable {
    let id: String
    let text: String
    let author: String?
    let category: QuoteCategory
    let sourceLabel: String?

    enum QuoteCategory: String, Codable, CaseIterable {
        case motivation
        case discipline
        case resilience
        case selfControl = "self_control"
        case mindset
        case courage
    }
}
