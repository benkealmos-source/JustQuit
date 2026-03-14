import Foundation

struct Story: Codable, Identifiable {
    let id: String
    let title: String
    let body: String
    let category: StoryCategory
    let sourceLabel: StorySourceLabel

    enum StoryCategory: String, Codable, CaseIterable {
        case recovery
        case motivation
        case reflection
        case beforeAfter = "before_after"
    }

    enum StorySourceLabel: String, Codable {
        case illustrative = "Illustrative"
        case communityInspired = "Community-Inspired"
    }
}
