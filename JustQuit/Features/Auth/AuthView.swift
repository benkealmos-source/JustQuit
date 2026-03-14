import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = true
    @State private var isLoading = false

    var body: some View {
        ZStack {
            JQColors.backgroundPrimary.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: JQSpacing.xl) {
                    Spacer(minLength: JQSpacing.xxxl)

                    header

                    formFields

                    PrimaryButton(
                        isSignUp ? "Create Account" : "Sign In",
                        icon: "arrow.right",
                        isLoading: isLoading
                    ) {
                        // TODO: Integrate Firebase Auth
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isLoading = false
                            appState.mockAuthenticate()
                        }
                    }

                    toggleMode

                    divider

                    socialButtons

                    Spacer()
                }
                .screenPadding()
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: JQSpacing.xs) {
            Text(isSignUp ? "Create Account" : "Welcome Back")
                .font(JQTypography.titleLarge)
                .foregroundStyle(JQColors.textPrimary)

            Text(isSignUp ? "Start your journey" : "Continue your progress")
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
        }
    }

    // MARK: - Form

    private var formFields: some View {
        VStack(spacing: JQSpacing.sm) {
            formField("Email", text: $email, icon: "envelope")
            formField("Password", text: $password, icon: "lock", isSecure: true)
        }
    }

    private func formField(
        _ placeholder: String,
        text: Binding<String>,
        icon: String,
        isSecure: Bool = false
    ) -> some View {
        HStack(spacing: JQSpacing.sm) {
            Image(systemName: icon)
                .foregroundStyle(JQColors.textTertiary)
                .frame(width: 20)

            if isSecure {
                SecureField(placeholder, text: text)
                    .foregroundStyle(JQColors.textPrimary)
            } else {
                TextField(placeholder, text: text)
                    .foregroundStyle(JQColors.textPrimary)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
            }
        }
        .font(JQTypography.body)
        .padding(JQSpacing.md)
        .background(
            RoundedRectangle(cornerRadius: JQRadius.md)
                .fill(JQColors.backgroundCard)
                .overlay(
                    RoundedRectangle(cornerRadius: JQRadius.md)
                        .stroke(JQColors.border, lineWidth: 1)
                )
        )
    }

    // MARK: - Toggle

    private var toggleMode: some View {
        Button {
            withAnimation { isSignUp.toggle() }
        } label: {
            Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                .font(JQTypography.captionMedium)
                .foregroundStyle(JQColors.accentElectric)
        }
    }

    // MARK: - Divider

    private var divider: some View {
        HStack(spacing: JQSpacing.sm) {
            Rectangle().fill(JQColors.separator).frame(height: 1)
            Text("or")
                .font(JQTypography.caption)
                .foregroundStyle(JQColors.textTertiary)
            Rectangle().fill(JQColors.separator).frame(height: 1)
        }
    }

    // MARK: - Social

    private var socialButtons: some View {
        VStack(spacing: JQSpacing.sm) {
            SecondaryButton("Continue with Apple", icon: "apple.logo") {
                // TODO: Integrate Apple Sign In
                appState.mockAuthenticate()
            }

            SecondaryButton("Continue with Google", icon: "g.circle") {
                // TODO: Integrate Google Sign In
                appState.mockAuthenticate()
            }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}
