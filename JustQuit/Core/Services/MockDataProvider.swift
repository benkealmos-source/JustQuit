import Foundation

enum MockData {

    // MARK: - User

    static let user = UserProfile(
        uid: "mock_uid_001",
        email: "user@justquit.app",
        displayName: "Alex",
        createdAt: Calendar.current.date(byAdding: .day, value: -14, to: .now) ?? .now,
        onboardingCompleted: true,
        selectedGoals: ["Better focus", "More confidence", "Healthier relationships"],
        currentStreakStart: Calendar.current.date(byAdding: .day, value: -7, to: .now),
        longestStreak: 14,
        relapseCount: 2,
        lastCheckInAt: Calendar.current.date(byAdding: .hour, value: -6, to: .now),
        reminderSettings: .default
    )

    // MARK: - Quotes

    static let quotes: [Quote] = [
        Quote(
            id: "q1",
            text: "Discipline is choosing between what you want now and what you want most.",
            author: "Abraham Lincoln",
            category: .discipline,
            sourceLabel: nil
        ),
        Quote(
            id: "q2",
            text: "The chains of habit are too weak to be felt until they are too strong to be broken.",
            author: "Samuel Johnson",
            category: .selfControl,
            sourceLabel: nil
        ),
        Quote(
            id: "q3",
            text: "Every morning you have two choices: continue to sleep with your dreams, or wake up and chase them.",
            author: nil,
            category: .motivation,
            sourceLabel: nil
        ),
        Quote(
            id: "q4",
            text: "You will never always be motivated. You have to learn to be disciplined.",
            author: nil,
            category: .discipline,
            sourceLabel: nil
        ),
        Quote(
            id: "q5",
            text: "The real test is not whether you avoid failure, because you won't. It's whether you let it harden or shame you into inaction.",
            author: "Barack Obama",
            category: .resilience,
            sourceLabel: nil
        ),
        Quote(
            id: "q6",
            text: "Self-control is strength. Calmness is mastery.",
            author: "James Allen",
            category: .selfControl,
            sourceLabel: nil
        ),
        Quote(
            id: "q7",
            text: "Small disciplines repeated with consistency every day lead to great achievements gained slowly over time.",
            author: "John C. Maxwell",
            category: .discipline,
            sourceLabel: nil
        )
    ]

    static var dailyQuote: Quote {
        let dayIndex = Calendar.current.component(.dayOfYear, from: .now)
        return quotes[dayIndex % quotes.count]
    }

    // MARK: - Stories

    static let stories: [Story] = [
        Story(
            id: "s1",
            title: "The 30-Day Turning Point",
            body: "This illustrative story follows someone who decided to track their habits daily. After 30 days of consistent effort, they noticed sharper focus at work and deeper conversations with friends. The key wasn't perfection — it was showing up each day.",
            category: .recovery,
            sourceLabel: .illustrative
        ),
        Story(
            id: "s2",
            title: "Replacing the Habit Loop",
            body: "A community-inspired reflection on how replacing late-night scrolling with reading changed everything. The urge didn't vanish overnight, but the new routine created space for it to fade.",
            category: .motivation,
            sourceLabel: .communityInspired
        ),
        Story(
            id: "s3",
            title: "Before and After: Energy Levels",
            body: "Many users with similar patterns report a noticeable shift in daily energy after 2–3 weeks. This illustrative concept explores what that shift might look like — from groggy mornings to waking up with clarity.",
            category: .beforeAfter,
            sourceLabel: .illustrative
        )
    ]

    // MARK: - Boredom Content

    static let boredomContent: [BoredomContent] = [
        BoredomContent(
            id: "b1",
            type: .breathing,
            title: "Box Breathing",
            subtitle: "4-4-4-4 breathing pattern to calm your mind",
            url: nil,
            iconName: "wind",
            metadata: ["duration": "3 minutes"]
        ),
        BoredomContent(
            id: "b2",
            type: .walk,
            title: "Take a Quick Walk",
            subtitle: "Step outside for 10 minutes. Change your environment.",
            url: nil,
            iconName: "figure.walk",
            metadata: nil
        ),
        BoredomContent(
            id: "b3",
            type: .exercise,
            title: "20 Push-ups",
            subtitle: "Physical effort redirects mental energy fast.",
            url: nil,
            iconName: "dumbbell",
            metadata: nil
        ),
        BoredomContent(
            id: "b4",
            type: .youtubeLink,
            title: "Focus Music — Deep Work",
            subtitle: "Lofi concentration playlist",
            url: "https://www.youtube.com/watch?v=jfKfPfyJRdk",
            iconName: "play.circle",
            metadata: nil
        ),
        BoredomContent(
            id: "b5",
            type: .book,
            title: "Atomic Habits by James Clear",
            subtitle: "A practical guide to building better habits",
            url: nil,
            iconName: "book",
            metadata: nil
        ),
        BoredomContent(
            id: "b6",
            type: .journalPrompt,
            title: "Journal: What triggered this urge?",
            subtitle: "Write for 5 minutes. No judgment.",
            url: nil,
            iconName: "pencil.and.scribble",
            metadata: nil
        ),
        BoredomContent(
            id: "b7",
            type: .meditation,
            title: "2-Minute Grounding",
            subtitle: "Name 5 things you see. 4 you hear. 3 you feel.",
            url: nil,
            iconName: "leaf",
            metadata: ["duration": "2 minutes"]
        )
    ]

    // MARK: - Weekly Check-in Statuses

    static func weeklyCheckIns() -> [DayStatus] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)

        return (-6...0).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: today)!
            let dayName = date.formatted(.dateTime.weekday(.abbreviated))
            let isToday = offset == 0
            let checkedIn = offset < 0 ? Bool.random() : false
            return DayStatus(dayLabel: dayName, date: date, isToday: isToday, checkedIn: checkedIn)
        }
    }
}

// MARK: - Weekly Day Status

struct DayStatus: Identifiable {
    let id = UUID()
    let dayLabel: String
    let date: Date
    let isToday: Bool
    let checkedIn: Bool
}
