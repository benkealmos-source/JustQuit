import SwiftUI

// MARK: - Onboarding Progress Indicator

struct OnboardingProgressBar: View {
    let currentStep: Int
    let totalSteps: Int

    private var progress: Double {
        guard totalSteps > 0 else { return 0 }
        return Double(currentStep) / Double(totalSteps)
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(JQColors.backgroundElevated)

                RoundedRectangle(cornerRadius: 3)
                    .fill(JQColors.accentGradient)
                    .frame(width: geo.size.width * progress)
                    .animation(.easeInOut(duration: JQTheme.animationDefault), value: progress)
            }
        }
        .frame(height: 6)
        .accessibilityValue("Step \(currentStep) of \(totalSteps)")
    }
}

// MARK: - Circular progress ring

struct ProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    let color: Color

    init(progress: Double, lineWidth: CGFloat = 4, color: Color = JQColors.accentElectric) {
        self.progress = progress
        self.lineWidth = lineWidth
        self.color = color
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(JQColors.backgroundElevated, lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: JQTheme.animationDefault), value: progress)
        }
    }
}

// MARK: - Step dots for smaller flows

struct StepDots: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: JQSpacing.xs) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Circle()
                    .fill(index <= currentStep ? JQColors.accentElectric : JQColors.backgroundElevated)
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut(duration: JQTheme.animationFast), value: currentStep)
            }
        }
        .accessibilityValue("Step \(currentStep + 1) of \(totalSteps)")
    }
}

#Preview {
    ZStack {
        JQColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: JQSpacing.xl) {
            OnboardingProgressBar(currentStep: 3, totalSteps: 8)
                .padding(.horizontal)

            ProgressRing(progress: 0.65)
                .frame(width: 60, height: 60)

            StepDots(totalSteps: 5, currentStep: 2)
        }
    }
}
