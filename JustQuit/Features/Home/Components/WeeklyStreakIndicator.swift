import SwiftUI

struct WeeklyStreakIndicator: View {
    let days: [DayStatus]

    var body: some View {
        GlassCard(cornerRadius: JQRadius.md, padding: JQSpacing.sm) {
            VStack(spacing: JQSpacing.xs) {
                HStack {
                    Text("This Week")
                        .font(JQTypography.captionMedium)
                        .foregroundStyle(JQColors.textSecondary)
                    Spacer()
                }

                HStack(spacing: JQSpacing.xs) {
                    ForEach(days) { day in
                        DayDot(day: day)
                    }
                }
            }
        }
    }
}

private struct DayDot: View {
    let day: DayStatus

    var body: some View {
        VStack(spacing: 4) {
            Text(day.dayLabel)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(day.isToday ? JQColors.accentElectric : JQColors.textTertiary)

            ZStack {
                Circle()
                    .fill(dotColor)
                    .frame(width: 28, height: 28)

                if day.checkedIn {
                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                } else if day.isToday {
                    Circle()
                        .stroke(JQColors.accentElectric, lineWidth: 2)
                        .frame(width: 28, height: 28)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityLabel("\(day.dayLabel): \(day.checkedIn ? "checked in" : day.isToday ? "today" : "not checked in")")
    }

    private var dotColor: Color {
        if day.checkedIn {
            return JQColors.accentGreen
        } else if day.isToday {
            return .clear
        } else {
            return JQColors.backgroundElevated
        }
    }
}
