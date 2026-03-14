import Foundation

struct BoredomContent: Codable, Identifiable {
    let id: String
    let type: ContentType
    let title: String
    let subtitle: String?
    let url: String?
    let iconName: String?
    let metadata: [String: String]?

    enum ContentType: String, Codable, CaseIterable {
        case breathing
        case meditation
        case walk
        case youtubeLink = "youtube_link"
        case book
        case exercise
        case journalPrompt = "journal_prompt"
    }
}
