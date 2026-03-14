import Foundation

struct AIGeneration: Codable, Identifiable {
    var id: String { "\(userId)_\(createdAt.timeIntervalSince1970)" }
    let userId: String
    let sourceImageUrl: String
    let resultImageUrl: String?
    let createdAt: Date
    let status: GenerationStatus
    let providerName: String
    let aiGenerationUsed: Bool
    let consentVersion: String

    enum GenerationStatus: String, Codable {
        case pending
        case processing
        case completed
        case failed
        case mock
    }
}

struct FutureSelfResult: Codable {
    let generation: AIGeneration
    let categories: [SoftCategory]
}

struct SoftCategory: Codable, Identifiable {
    let id: String
    let label: String
    let value: SoftLevel
    let description: String

    enum SoftLevel: String, Codable {
        case emerging = "Emerging"
        case developing = "Developing"
        case strong = "Strong"
        case radiant = "Radiant"
    }

    static let illustrativeDefaults: [SoftCategory] = [
        SoftCategory(
            id: "confidence",
            label: "Confidence Projection",
            value: .developing,
            description: "Based on your answers, this illustrative preview reflects growing inner confidence."
        ),
        SoftCategory(
            id: "presentation",
            label: "Self-Presentation Potential",
            value: .emerging,
            description: "An illustrative reflection of how self-care and discipline may influence how you carry yourself."
        ),
        SoftCategory(
            id: "energy",
            label: "Energy Projection",
            value: .strong,
            description: "Users with similar patterns often report feeling more energized and present."
        ),
        SoftCategory(
            id: "discipline",
            label: "Discipline Signal",
            value: .developing,
            description: "An illustrative indicator of the internal discipline you're building through this journey."
        )
    ]
}
