import Foundation

struct ReminderSettings: Codable {
    var morningEnabled: Bool
    var morningTime: DateComponents
    var eveningEnabled: Bool
    var eveningTime: DateComponents
    var highRiskEnabled: Bool
    var highRiskTime: DateComponents
    var milestoneRemindersEnabled: Bool

    static let `default` = ReminderSettings(
        morningEnabled: true,
        morningTime: DateComponents(hour: 8, minute: 0),
        eveningEnabled: true,
        eveningTime: DateComponents(hour: 21, minute: 0),
        highRiskEnabled: false,
        highRiskTime: DateComponents(hour: 23, minute: 0),
        milestoneRemindersEnabled: true
    )
}
