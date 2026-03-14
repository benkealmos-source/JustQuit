import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var appState: AppState

    private let profile: RecoveryProfileType = .habitBreaker

    var body: some View {
        ZStack {
            StarfieldBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: JQSpacing.lg) {
                    headerSection
                    profileCard
                    milestoneCard
                    improvementsCard
                    ctaSection
                }
                .screenPadding()
                .padding(.vertical, JQSpacing.xl)
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: JQSpacing.sm) {
            Image(systemName: "chart.bar.doc.horizontal.fill")
                .font(.system(size: 40))
                .foregroundStyle(JQColors.accentGradient)

            Text("Your Profile")
                .font(JQTypography.titleLarge)
                .foregroundStyle(JQColors.textPrimary)

            Text("Based on your answers")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
        }
    }

    // MARK: - Profile Card

    private var profileCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                Text(profile.rawValue)
                    .font(JQTypography.titleMedium)
                    .foregroundStyle(JQColors.accentElectric)

                Text(profile.summary)
                    .font(JQTypography.body)
                    .foregroundStyle(JQColors.textSecondary)
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Milestone Card

    private var milestoneCard: some View {
        GlassCard {
            HStack(spacing: JQSpacing.sm) {
                Image(systemName: "clock.badge.checkmark")
                    .font(.system(size: 22))
                    .foregroundStyle(JQColors.accentGold)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Estimated Milestone Window")
                        .font(JQTypography.captionMedium)
                        .foregroundStyle(JQColors.textTertiary)
                    Text(profile.estimatedMilestoneWindow)
                        .font(JQTypography.bodyMedium)
                        .foregroundStyle(JQColors.textPrimary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Improvements

    private var improvementsCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                Text("Top Likely Improvements")
                    .font(JQTypography.emphasisLarge)
                    .foregroundStyle(JQColors.textPrimary)

                ForEach(profile.topImprovements, id: \.self) { item in
                    HStack(spacing: JQSpacing.sm) {
                        Image(systemName: "arrow.up.right.circle.fill")
                            .foregroundStyle(JQColors.accentGreen)
                            .font(.system(size: 16))
                        Text(item)
                            .font(JQTypography.body)
                            .foregroundStyle(JQColors.textSecondary)
                    }
                }

                Text("Based on commonly reported experiences. Not medical advice.")
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary.opacity(0.6))
                    .italic()
                    .padding(.top, JQSpacing.xxs)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - CTA

    private var ctaSection: some View {
        VStack(spacing: JQSpacing.sm) {
            PrimaryButton("Unlock Your Plan", icon: "lock.open.fill") {
                withAnimation {
                    appState.onboardingState = .complete
                }
            }

            Text("Premium features required")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
        }
        .padding(.top, JQSpacing.md)
    }
}

#Preview {
    ResultView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}
