import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            StarfieldBackground()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: JQSpacing.lg) {
                    header
                    mascotSection
                    motivationBanner
                    WeeklyStreakIndicator(days: viewModel.weeklyDays)
                    quickActions
                    DailyQuoteCard(quote: viewModel.dailyQuote)
                    StreakStatsRow(
                        longestStreak: viewModel.longestStreak,
                        relapseCount: viewModel.relapseCount
                    )
                    RewireProgressCard(
                        progress: viewModel.rewireProgress,
                        label: viewModel.rewireLabel,
                        streakDays: viewModel.streakDays
                    )
                    Spacer(minLength: JQSpacing.xxl)
                }
                .screenPadding()
                .padding(.top, JQSpacing.md)
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(greeting)
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)
                Text(viewModel.userProfile.displayName.isEmpty
                     ? "Welcome"
                     : viewModel.userProfile.displayName)
                    .font(JQTypography.titleLarge)
                    .foregroundStyle(JQColors.textPrimary)
            }

            Spacer()

            streakBadge
        }
    }

    private var streakBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "flame.fill")
                .foregroundStyle(JQColors.accentGold)
                .font(.system(size: 16, weight: .semibold))
            Text("\(viewModel.streakDays)")
                .font(JQTypography.emphasisLarge)
                .foregroundStyle(JQColors.accentGold)
        }
        .padding(.horizontal, JQSpacing.sm)
        .padding(.vertical, JQSpacing.xs)
        .background(
            Capsule()
                .fill(JQColors.accentGold.opacity(0.12))
                .overlay(
                    Capsule()
                        .stroke(JQColors.accentGold.opacity(0.2), lineWidth: 1)
                )
        )
        .accessibilityLabel("Current streak: \(viewModel.streakDays) days")
    }

    // MARK: - Mascot

    private var mascotSection: some View {
        VStack(spacing: JQSpacing.xs) {
            MascotStreakView(
                streakDays: viewModel.streakDays,
                longestStreak: viewModel.longestStreak
            )

            Text(viewModel.streakTier.tierLabel)
                .font(JQTypography.captionMedium)
                .foregroundStyle(JQColors.textTertiary)
                .textCase(.uppercase)
                .tracking(2)
        }
    }

    // MARK: - Motivation

    private var motivationBanner: some View {
        Text(viewModel.motivationalMessage)
            .font(JQTypography.body)
            .foregroundStyle(JQColors.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, JQSpacing.lg)
    }

    // MARK: - Quick Actions

    private var quickActions: some View {
        QuickActionsRow(
            onCheckIn: { viewModel.checkIn() },
            onPanic: { viewModel.showPanicSheet = true },
            onBreathing: { appState.currentTab = .bored }
        )
    }

    // MARK: - Greeting

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<22: return "Good evening"
        default: return "Stay strong tonight"
        }
    }
}

#Preview {
    let state = AppState()

    HomeView()
        .environmentObject(state)
        .preferredColorScheme(.dark)
}
