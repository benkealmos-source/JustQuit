import SwiftUI

// MARK: - JustQuit Typography System

enum JQTypography {

    // MARK: Display

    static let displayLarge = Font.system(size: 48, weight: .bold, design: .rounded)
    static let displayMedium = Font.system(size: 36, weight: .bold, design: .rounded)

    // MARK: Titles

    static let titleLarge = Font.system(size: 28, weight: .bold, design: .rounded)
    static let titleMedium = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let titleSmall = Font.system(size: 18, weight: .semibold, design: .rounded)

    // MARK: Body

    static let bodyLarge = Font.system(size: 17, weight: .regular, design: .rounded)
    static let body = Font.system(size: 15, weight: .regular, design: .rounded)
    static let bodyMedium = Font.system(size: 15, weight: .medium, design: .rounded)

    // MARK: Captions

    static let caption = Font.system(size: 13, weight: .regular, design: .rounded)
    static let captionMedium = Font.system(size: 13, weight: .medium, design: .rounded)

    // MARK: Emphasis

    static let emphasis = Font.system(size: 15, weight: .semibold, design: .rounded)
    static let emphasisLarge = Font.system(size: 17, weight: .semibold, design: .rounded)

    // MARK: Numbers (for streak counters, stats)

    static let numberDisplay = Font.system(size: 56, weight: .heavy, design: .rounded)
    static let numberLarge = Font.system(size: 40, weight: .bold, design: .rounded)
    static let numberMedium = Font.system(size: 28, weight: .bold, design: .rounded)
    static let numberSmall = Font.system(size: 20, weight: .bold, design: .rounded)

    // MARK: Buttons

    static let buttonPrimary = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let buttonSecondary = Font.system(size: 15, weight: .medium, design: .rounded)
    static let buttonSmall = Font.system(size: 13, weight: .semibold, design: .rounded)

    // MARK: Chip / Tag

    static let chip = Font.system(size: 14, weight: .medium, design: .rounded)
}
