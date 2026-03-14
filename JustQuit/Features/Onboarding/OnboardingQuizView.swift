import SwiftUI

struct OnboardingQuizView: View {
    @EnvironmentObject private var appState: AppState
    @State private var currentStep = 0
    @State private var answers = OnboardingDraft()

    private let steps = OnboardingStep.allSteps

    var body: some View {
        ZStack {
            JQColors.backgroundPrimary.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                OnboardingProgressBar(currentStep: currentStep + 1, totalSteps: steps.count)
                    .padding(.horizontal, JQSpacing.screenHorizontal)
                    .padding(.top, JQSpacing.xs)

                TabView(selection: $currentStep) {
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        stepView(for: step)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: JQTheme.animationDefault), value: currentStep)

                bottomNav
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            if currentStep > 0 {
                Button {
                    withAnimation { currentStep -= 1 }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(JQColors.textSecondary)
                        .frame(width: JQTheme.minTapTarget, height: JQTheme.minTapTarget)
                }
            }

            Spacer()

            Text("Step \(currentStep + 1) of \(steps.count)")
                .font(JQTypography.captionMedium)
                .foregroundStyle(JQColors.textTertiary)

            Spacer()

            Color.clear
                .frame(width: JQTheme.minTapTarget, height: JQTheme.minTapTarget)
        }
        .screenPadding()
    }

    // MARK: - Step Content

    @ViewBuilder
    private func stepView(for step: OnboardingStep) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: JQSpacing.lg) {
                Text(step.title)
                    .font(JQTypography.titleLarge)
                    .foregroundStyle(JQColors.textPrimary)

                if let subtitle = step.subtitle {
                    Text(subtitle)
                        .font(JQTypography.body)
                        .foregroundStyle(JQColors.textSecondary)
                }

                stepInput(for: step)
            }
            .screenPadding()
            .padding(.top, JQSpacing.xl)
        }
    }

    @ViewBuilder
    private func stepInput(for step: OnboardingStep) -> some View {
        switch step.type {
        case .singleChoice(let options):
            VStack(spacing: JQSpacing.sm) {
                ForEach(options, id: \.self) { option in
                    let isSelected = answers.singleSelections[step.id] == option
                    Button {
                        answers.singleSelections[step.id] = option
                    } label: {
                        HStack {
                            Text(option)
                                .font(JQTypography.bodyMedium)
                                .foregroundStyle(isSelected ? JQColors.textOnAccent : JQColors.textPrimary)
                            Spacer()
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(JQColors.textOnAccent)
                            }
                        }
                        .padding(JQSpacing.md)
                        .background(
                            RoundedRectangle(cornerRadius: JQRadius.md)
                                .fill(isSelected ? JQColors.accentElectric : JQColors.backgroundCard)
                                .overlay(
                                    RoundedRectangle(cornerRadius: JQRadius.md)
                                        .stroke(isSelected ? Color.clear : JQColors.border, lineWidth: 1)
                                )
                        )
                    }
                    .animation(.easeInOut(duration: JQTheme.animationFast), value: isSelected)
                }
            }

        case .multiChoice(let options):
            ChipGroup(
                options: options,
                selected: Binding(
                    get: { answers.multiSelections[step.id] ?? [] },
                    set: { answers.multiSelections[step.id] = $0 }
                )
            )

        case .slider(let range, let unit):
            VStack(spacing: JQSpacing.sm) {
                let value = Binding(
                    get: { answers.sliderValues[step.id] ?? Double(range.lowerBound) },
                    set: { answers.sliderValues[step.id] = $0 }
                )
                Text("\(Int(value.wrappedValue)) \(unit)")
                    .font(JQTypography.numberMedium)
                    .foregroundStyle(JQColors.accentElectric)

                Slider(
                    value: value,
                    in: Double(range.lowerBound)...Double(range.upperBound),
                    step: 1
                )
                .tint(JQColors.accentElectric)

                HStack {
                    Text("\(range.lowerBound)")
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                    Spacer()
                    Text("\(range.upperBound)")
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }
            }
        }
    }

    // MARK: - Bottom Nav

    private var bottomNav: some View {
        VStack(spacing: JQSpacing.sm) {
            let isLast = currentStep == steps.count - 1
            PrimaryButton(isLast ? "See My Results" : "Continue", icon: isLast ? "sparkles" : "arrow.right") {
                if isLast {
                    withAnimation {
                        appState.onboardingState = .result
                    }
                } else {
                    withAnimation { currentStep += 1 }
                }
            }
        }
        .screenPadding()
        .padding(.bottom, JQSpacing.lg)
    }
}

// MARK: - Draft Answers (local state during quiz)

private struct OnboardingDraft {
    var singleSelections: [String: String] = [:]
    var multiSelections: [String: Set<String>] = [:]
    var sliderValues: [String: Double] = [:]
}

// MARK: - Onboarding Step Definition

struct OnboardingStep: Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let type: InputType

    enum InputType {
        case singleChoice([String])
        case multiChoice([String])
        case slider(ClosedRange<Int>, unit: String)
    }

    static let allSteps: [OnboardingStep] = [
        OnboardingStep(
            id: "age",
            title: "What's your age range?",
            subtitle: nil,
            type: .singleChoice(["Under 18", "18–24", "25–34", "35–44", "45+"])
        ),
        OnboardingStep(
            id: "gender",
            title: "How do you identify?",
            subtitle: "Optional — helps personalize your experience.",
            type: .singleChoice(["Male", "Female", "Non-binary", "Prefer not to say"])
        ),
        OnboardingStep(
            id: "frequency",
            title: "How often do you currently struggle with this habit?",
            subtitle: nil,
            type: .singleChoice(["Rarely", "A few times a month", "Weekly", "Multiple times a week", "Daily"])
        ),
        OnboardingStep(
            id: "triggers",
            title: "What are your most common triggers?",
            subtitle: "Select all that apply.",
            type: .multiChoice(["Stress", "Boredom", "Loneliness", "Late night", "Social media", "Anxiety", "Procrastination", "Being alone"])
        ),
        OnboardingStep(
            id: "risk_time",
            title: "When is your highest-risk time?",
            subtitle: nil,
            type: .singleChoice(["Morning", "Afternoon", "Evening", "Late night", "Random / varies"])
        ),
        OnboardingStep(
            id: "goals",
            title: "What do you hope to gain?",
            subtitle: "Select what matters most.",
            type: .multiChoice(["Better focus", "More confidence", "Healthier relationships", "More energy", "Self-respect", "Mental clarity", "Better sleep", "Emotional stability"])
        ),
        OnboardingStep(
            id: "confidence",
            title: "How confident are you that you can change?",
            subtitle: "1 = Not at all, 10 = Extremely confident",
            type: .slider(1...10, unit: "/ 10")
        ),
        OnboardingStep(
            id: "reminders",
            title: "Would you like daily reminders?",
            subtitle: "We can send gentle check-in nudges to keep you on track.",
            type: .singleChoice(["Yes, morning & evening", "Just morning", "Just evening", "No reminders"])
        )
    ]
}

#Preview {
    OnboardingQuizView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}
