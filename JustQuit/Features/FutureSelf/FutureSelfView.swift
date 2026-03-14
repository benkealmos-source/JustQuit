import SwiftUI

struct FutureSelfView: View {
    @State private var hasGenerated = false
    @State private var showConsent = false
    @State private var isProcessing = false

    private let categories = SoftCategory.illustrativeDefaults

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                ScrollView(showsIndicators: false) {
                    if hasGenerated {
                        resultContent
                    } else {
                        introContent
                    }
                }
            }
            .navigationTitle("Future Self")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(isPresented: $showConsent) {
                consentSheet
            }
        }
    }

    // MARK: - Intro (before generation)

    private var introContent: some View {
        VStack(spacing: JQSpacing.xl) {
            Spacer(minLength: JQSpacing.xxl)

            Image(systemName: "sparkles")
                .font(.system(size: 56))
                .foregroundStyle(JQColors.accentGradient)
                .shadow(color: JQColors.accentElectric.opacity(0.3), radius: 16)

            VStack(spacing: JQSpacing.sm) {
                Text("Visualize Your Future Self")
                    .font(JQTypography.titleLarge)
                    .foregroundStyle(JQColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Upload a selfie and get an illustrative preview of the confident, disciplined version of yourself you're building toward.")
                    .font(JQTypography.body)
                    .foregroundStyle(JQColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            .screenPadding()

            GlassCard {
                VStack(alignment: .leading, spacing: JQSpacing.sm) {
                    infoRow("sparkles", "One-time feature — make it count")
                    infoRow("eye.slash", "Your photo is private and encrypted")
                    infoRow("info.circle", "Results are illustrative, not predictive")
                    infoRow("brain.head.profile", "Not a medical or clinical assessment")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .screenPadding()

            PrimaryButton("Begin Visualization", icon: "camera.fill", isLoading: isProcessing) {
                showConsent = true
            }
            .screenPadding()

            Spacer(minLength: JQSpacing.xxl)
        }
    }

    private func infoRow(_ icon: String, _ text: String) -> some View {
        HStack(spacing: JQSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(JQColors.accentCyan)
                .frame(width: 20)
            Text(text)
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
        }
    }

    // MARK: - Result (after generation)

    private var resultContent: some View {
        VStack(spacing: JQSpacing.lg) {
            VStack(spacing: JQSpacing.sm) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(.system(size: 64))
                    .foregroundStyle(JQColors.accentGradient)

                Text("Your Future Self")
                    .font(JQTypography.titleLarge)
                    .foregroundStyle(JQColors.textPrimary)

                Text("An illustrative visualization based on your journey")
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, JQSpacing.xl)

            placeholderImage

            ForEach(categories) { category in
                categoryCard(category)
            }

            Text("These categories are illustrative and for motivational purposes only. They do not represent medical, clinical, or objective assessments.")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary.opacity(0.6))
                .italic()
                .multilineTextAlignment(.center)
                .screenPadding()

            Spacer(minLength: JQSpacing.xxl)
        }
        .screenPadding()
    }

    private var placeholderImage: some View {
        RoundedRectangle(cornerRadius: JQRadius.xl)
            .fill(JQColors.backgroundCard)
            .frame(height: 280)
            .overlay(
                VStack(spacing: JQSpacing.sm) {
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundStyle(JQColors.textTertiary)
                    Text("AI-generated image would appear here")
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: JQRadius.xl)
                    .stroke(JQColors.border, lineWidth: 1)
            )
    }

    private func categoryCard(_ category: SoftCategory) -> some View {
        GlassCard(cornerRadius: JQRadius.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(category.label)
                        .font(JQTypography.emphasisLarge)
                        .foregroundStyle(JQColors.textPrimary)
                    Text(category.description)
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                        .lineLimit(2)
                }

                Spacer()

                Text(category.value.rawValue)
                    .font(JQTypography.buttonSmall)
                    .foregroundStyle(levelColor(category.value))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule().fill(levelColor(category.value).opacity(0.12))
                    )
            }
        }
    }

    private func levelColor(_ level: SoftCategory.SoftLevel) -> Color {
        switch level {
        case .emerging: return JQColors.accentElectric
        case .developing: return JQColors.accentCyan
        case .strong: return JQColors.accentGreen
        case .radiant: return JQColors.accentGold
        }
    }

    // MARK: - Consent Sheet

    private var consentSheet: some View {
        ZStack {
            JQColors.backgroundSheet.ignoresSafeArea()

            VStack(spacing: JQSpacing.lg) {
                Text("Before We Begin")
                    .font(JQTypography.titleMedium)
                    .foregroundStyle(JQColors.textPrimary)
                    .padding(.top, JQSpacing.xl)

                VStack(alignment: .leading, spacing: JQSpacing.sm) {
                    consentItem("Your selfie is used only for this visualization")
                    consentItem("The result is illustrative — not a real prediction")
                    consentItem("You can delete your photos at any time in Settings")
                    consentItem("This is a one-time feature per account")
                    consentItem("This is not a medical or clinical assessment")
                }
                .screenPadding()

                Spacer()

                VStack(spacing: JQSpacing.sm) {
                    PrimaryButton("I Understand — Continue", icon: "camera.fill") {
                        showConsent = false
                        // TODO: Open photo picker + call Cloud Function
                        isProcessing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isProcessing = false
                            hasGenerated = true
                        }
                    }

                    SecondaryButton("Cancel") {
                        showConsent = false
                    }
                }
                .screenPadding()
                .padding(.bottom, JQSpacing.lg)
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private func consentItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: JQSpacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(JQColors.accentGreen)
                .font(.system(size: 16))
            Text(text)
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
        }
    }
}

#Preview {
    FutureSelfView()
        .preferredColorScheme(.dark)
}
