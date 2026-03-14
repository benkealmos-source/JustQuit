import Foundation

extension Date {

    var streakDisplayString: String {
        let days = daysSince
        if days == 0 { return "Today" }
        if days == 1 { return "1 day" }
        return "\(days) days"
    }

    var daysSince: Int {
        max(0, Calendar.current.dateComponents([.day], from: self, to: .now).day ?? 0)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var shortFormatted: String {
        formatted(.dateTime.month(.abbreviated).day())
    }
}
