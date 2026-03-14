import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var appState: AppState
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0
    @State private var showCTA = false

    var body: some View {
        ZStack {
            StarfieldBackground()

            VStack(spacing: JQSpacing.xxl) {
                Spacer()

                branding
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                Spacer()

                if showCTA {
                    ctaSection
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .screenPadding()
            .padding(.bottom, JQSpacing.xxl)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                logoScale = 1.0
                logoOpacity = 1
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.6)) {
                showCTA = true
            }
        }
    }

    private var branding: some View {
        VStack(spacing: JQSpacing.md) {
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [JQColors.accentElectric.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 20,
                            endRadius: 70
                        )
                    )
                    .frame(width: 140, height: 140)

                Image(systemName: "shield.checkered")
                    .font(.system(size: 56, weight: .medium))
                    .foregroundStyle(JQColors.accentGradient)
            }

            Text("JustQuit")
                .font(JQTypography.displayLarge)
                .foregroundStyle(JQColors.textPrimary)

            Text("Reclaim your focus. Rebuild your discipline.")
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    private var ctaSection: some View {
        VStack(spacing: JQSpacing.sm) {
            PrimaryButton("Begin Your Journey", icon: "arrow.right") {
                withAnimation {
                    appState.onboardingState = .quiz
                }
            }

            Text("Free personalized assessment")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
        }
    }
}

#Preview {
    LaunchView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}
