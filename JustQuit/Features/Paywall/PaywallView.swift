import SwiftUI

struct PaywallView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedPlan: PlanOption = .yearly
    @State private var isPurchasing = false

    var body: some View {
        ZStack {
            StarfieldBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: JQSpacing.lg) {
                    header
                    featuresList
                    planCards
                    purchaseButton
                    legalLinks
                }
                .screenPadding()
                .padding(.vertical, JQSpacing.xl)
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: JQSpacing.sm) {
            Image(systemName: "crown.fill")
                .font(.system(size: 44))
                .foregroundStyle(JQColors.accentGold)
                .shadow(color: JQColors.accentGold.opacity(0.3), radius: 12)

            Text("Unlock JustQuit")
                .font(JQTypography.titleLarge)
                .foregroundStyle(JQColors.textPrimary)

            Text("Full access to every tool for your journey")
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Features

    private var featuresList: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                featureRow("Streak tracking & daily check-ins", icon: "flame.fill")
                featureRow("Motivational stories & quotes", icon: "book.fill")
                featureRow("AI Future Self visualization (one-time)", icon: "sparkles")
                featureRow("Panic button & urge interruption", icon: "exclamationmark.shield.fill")
                featureRow("Smart reminders", icon: "bell.fill")
                featureRow("Progress insights", icon: "chart.line.uptrend.xyaxis")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func featureRow(_ text: String, icon: String) -> some View {
        HStack(spacing: JQSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(JQColors.accentElectric)
                .frame(width: 24)
            Text(text)
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textPrimary)
        }
    }

    // MARK: - Plans

    private var planCards: some View {
        VStack(spacing: JQSpacing.sm) {
            ForEach(PlanOption.allCases) { plan in
                planCard(plan)
            }
        }
    }

    private func planCard(_ plan: PlanOption) -> some View {
        let isSelected = selectedPlan == plan
        return Button {
            selectedPlan = plan
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: JQSpacing.xs) {
                        Text(plan.title)
                            .font(JQTypography.emphasisLarge)
                            .foregroundStyle(JQColors.textPrimary)
                        if plan.isBestValue {
                            Text("BEST VALUE")
                                .font(.system(size: 9, weight: .bold, design: .rounded))
                                .foregroundStyle(JQColors.textOnAccent)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(
                                    Capsule().fill(JQColors.accentGold)
                                )
                        }
                    }
                    Text(plan.subtitle)
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(plan.price)
                        .font(JQTypography.emphasisLarge)
                        .foregroundStyle(JQColors.textPrimary)
                    if let perMonth = plan.perMonth {
                        Text(perMonth)
                            .font(JQTypography.caption)
                            .foregroundStyle(JQColors.textTertiary)
                    }
                }
            }
            .padding(JQSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: JQRadius.md)
                    .fill(isSelected ? JQColors.accentElectric.opacity(0.1) : JQColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: JQRadius.md)
                            .stroke(isSelected ? JQColors.accentElectric : JQColors.border, lineWidth: isSelected ? 2 : 1)
                    )
            )
            .animation(.easeInOut(duration: JQTheme.animationFast), value: isSelected)
        }
    }

    // MARK: - Purchase

    private var purchaseButton: some View {
        VStack(spacing: JQSpacing.sm) {
            PrimaryButton("Subscribe Now", icon: "lock.open.fill", isLoading: isPurchasing) {
                // TODO: Integrate RevenueCat purchase flow
                isPurchasing = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isPurchasing = false
                    appState.mockActivatePremium()
                    appState.mockAuthenticate()
                }
            }

            SecondaryButton("Restore Purchases", icon: "arrow.clockwise") {
                // TODO: Integrate RevenueCat restore
                appState.mockActivatePremium()
                appState.mockAuthenticate()
            }
        }
    }

    // MARK: - Legal

    private var legalLinks: some View {
        HStack(spacing: JQSpacing.md) {
            TextLinkButton(title: "Terms of Use") {}
            TextLinkButton(title: "Privacy Policy") {}
        }
        .padding(.top, JQSpacing.xs)
    }
}

// MARK: - Plan Option

enum PlanOption: String, CaseIterable, Identifiable {
    case monthly
    case yearly
    case lifetime

    var id: String { rawValue }

    var title: String {
        switch self {
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        case .lifetime: return "Lifetime"
        }
    }

    var subtitle: String {
        switch self {
        case .monthly: return "Intro: $9.99 for first 3 months"
        case .yearly: return "Save 58% vs monthly"
        case .lifetime: return "One-time purchase"
        }
    }

    var price: String {
        switch self {
        case .monthly: return "$9.99/mo"
        case .yearly: return "$49.99/yr"
        case .lifetime: return "$99.99"
        }
    }

    var perMonth: String? {
        switch self {
        case .monthly: return nil
        case .yearly: return "$4.17/mo"
        case .lifetime: return "forever"
        }
    }

    var isBestValue: Bool { self == .yearly }
}

#Preview {
    PaywallView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}
