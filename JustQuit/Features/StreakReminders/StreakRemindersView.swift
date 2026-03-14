import SwiftUI

struct StreakRemindersView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showRelapseConfirm = false

    private var profile: UserProfile {
        appState.userProfile
    }

    var body: some View {
        NavigationStack {
            ZStack {
                JQColors.backgroundPrimary.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: JQSpacing.lg) {
                        streakOverview
                        checkInCard
                        reminderSection
                        relapseSection
                    }
                    .screenPadding()
                    .padding(.vertical, JQSpacing.md)
                }
            }
            .navigationTitle("Streak")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .alert("Log a Relapse?", isPresented: $showRelapseConfirm) {
                Button("Yes, Reset Streak", role: .destructive) {
                    // TODO: Persist relapse to Firestore
                    appState.userProfile.relapseCount += 1
                    appState.userProfile.currentStreakStart = .now
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will reset your current streak. Your longest streak record is preserved. You're not failing — you're learning.")
            }
        }
    }

    // MARK: - Streak Overview

    private var streakOverview: some View {
        VStack(spacing: JQSpacing.md) {
            GlassCard {
                HStack {
                    statBlock(
                        value: "\(profile.currentStreakDays)",
                        label: "Current Streak",
                        icon: "flame.fill",
                        color: JQColors.accentElectric
                    )

                    Spacer()

                    statBlock(
                        value: "\(profile.longestStreak)",
                        label: "Longest",
                        icon: "trophy.fill",
                        color: JQColors.accentGold
                    )

                    Spacer()

                    statBlock(
                        value: "\(profile.relapseCount)",
                        label: "Relapses",
                        icon: "arrow.counterclockwise",
                        color: JQColors.accentUrgent
                    )
                }
            }

            if let start = profile.currentStreakStart {
                Text("Started \(start.shortFormatted)")
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)
            }
        }
    }

    private func statBlock(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)
            Text(value)
                .font(JQTypography.numberMedium)
                .foregroundStyle(JQColors.textPrimary)
            Text(label)
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Check In

    private var checkInCard: some View {
        GlassCard {
            VStack(spacing: JQSpacing.sm) {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(JQColors.accentGreen)
                    Text("Daily Check-In")
                        .font(JQTypography.emphasisLarge)
                        .foregroundStyle(JQColors.textPrimary)
                    Spacer()
                }

                if let last = profile.lastCheckInAt, last.isToday {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(JQColors.accentGreen)
                        Text("Checked in today")
                            .font(JQTypography.body)
                            .foregroundStyle(JQColors.accentGreen)
                    }
                } else {
                    PrimaryButton("Check In Now", icon: "checkmark") {
                        // TODO: Persist check-in to Firestore
                        appState.userProfile.lastCheckInAt = .now
                    }
                }
            }
        }
    }

    // MARK: - Reminders

    private var reminderSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundStyle(JQColors.accentCyan)
                    Text("Reminders")
                        .font(JQTypography.emphasisLarge)
                        .foregroundStyle(JQColors.textPrimary)
                }

                reminderRow("Morning", time: "8:00 AM", isOn: profile.reminderSettings.morningEnabled)
                reminderRow("Evening", time: "9:00 PM", isOn: profile.reminderSettings.eveningEnabled)
                reminderRow("High-Risk Hour", time: "11:00 PM", isOn: profile.reminderSettings.highRiskEnabled)
                reminderRow("Milestones", time: nil, isOn: profile.reminderSettings.milestoneRemindersEnabled)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func reminderRow(_ label: String, time: String?, isOn: Bool) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(JQTypography.bodyMedium)
                    .foregroundStyle(JQColors.textPrimary)
                if let time {
                    Text(time)
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }
            }

            Spacer()

            Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isOn ? JQColors.accentGreen : JQColors.textTertiary)
            // TODO: Make toggleable and persist reminder settings
        }
        .padding(.vertical, JQSpacing.xxs)
    }

    // MARK: - Relapse

    private var relapseSection: some View {
        VStack(spacing: JQSpacing.sm) {
            Button {
                showRelapseConfirm = true
            } label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Log a Relapse")
                }
                .font(JQTypography.buttonSecondary)
                .foregroundStyle(JQColors.accentUrgent.opacity(0.8))
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: JQRadius.button)
                        .stroke(JQColors.accentUrgent.opacity(0.3), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: JQRadius.button)
                                .fill(JQColors.accentUrgent.opacity(0.06))
                        )
                )
            }

            Text("Setbacks are part of the process. Logging helps you learn.")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    let state = AppState()
    state.userProfile = MockData.user

    return StreakRemindersView()
        .environmentObject(state)
        .preferredColorScheme(.dark)
}
