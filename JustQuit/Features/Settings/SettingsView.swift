import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showDeleteAccount = false
    @State private var showDeleteAIPhotos = false
    @State private var showSignOut = false

    var body: some View {
        NavigationStack {
            ZStack {
                JQColors.backgroundPrimary.ignoresSafeArea()

                List {
                    accountSection
                    subscriptionSection
                    notificationsSection
                    dataSection
                    legalSection
                    aboutSection
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .alert("Sign Out?", isPresented: $showSignOut) {
                Button("Sign Out", role: .destructive) {
                    appState.mockSignOut()
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert("Delete Account?", isPresented: $showDeleteAccount) {
                Button("Delete", role: .destructive) {
                    // TODO: Implement account deletion via Firebase
                    appState.mockSignOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete your account and all data. This cannot be undone.")
            }
            .alert("Delete AI Photos?", isPresented: $showDeleteAIPhotos) {
                Button("Delete Photos", role: .destructive) {
                    // TODO: Delete AI photos from Firebase Storage
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete your AI-generated photos from our servers.")
            }
        }
    }

    // MARK: - Account

    private var accountSection: some View {
        Section {
            settingsRow("person.circle", "Account", value: appState.userProfile.email)
        } header: {
            sectionHeader("Account")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - Subscription

    private var subscriptionSection: some View {
        Section {
            settingsRow("crown.fill", "Manage Subscription", color: JQColors.accentGold) {
                // TODO: Open RevenueCat management URL
            }
            settingsRow("arrow.clockwise", "Restore Purchases") {
                // TODO: RevenueCat restore
            }
        } header: {
            sectionHeader("Subscription")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - Notifications

    private var notificationsSection: some View {
        Section {
            settingsRow("bell.fill", "Notification Preferences") {
                // TODO: Open notification settings
            }
        } header: {
            sectionHeader("Notifications")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - Data

    private var dataSection: some View {
        Section {
            settingsRow("trash", "Delete Local Data", color: JQColors.accentUrgent) {
                // TODO: Clear local caches
            }
            settingsRow("photo.on.rectangle.angled", "Delete AI Photos", color: JQColors.accentUrgent) {
                showDeleteAIPhotos = true
            }
            settingsRow("person.crop.circle.badge.xmark", "Delete Account", color: JQColors.accentUrgent) {
                showDeleteAccount = true
            }
        } header: {
            sectionHeader("Data & Privacy")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - Legal

    private var legalSection: some View {
        Section {
            settingsRow("doc.text", "Privacy Policy") {
                // TODO: Open privacy policy URL
            }
            settingsRow("doc.text", "Terms of Use") {
                // TODO: Open terms URL
            }
            settingsRow("envelope", "Support") {
                // TODO: Open support email or form
            }
        } header: {
            sectionHeader("Legal")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - About

    private var aboutSection: some View {
        Section {
            settingsRow("info.circle", "App Version", value: "1.0.0 (Phase 1)")

            Button {
                showSignOut = true
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundStyle(JQColors.accentUrgent)
                        .frame(width: 24)
                    Text("Sign Out")
                        .foregroundStyle(JQColors.accentUrgent)
                    Spacer()
                }
                .font(JQTypography.body)
            }
        } header: {
            sectionHeader("About")
        }
        .listRowBackground(JQColors.backgroundCard)
    }

    // MARK: - Helpers

    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(JQTypography.captionMedium)
            .foregroundStyle(JQColors.textTertiary)
    }

    private func settingsRow(
        _ icon: String,
        _ title: String,
        value: String? = nil,
        color: Color = JQColors.accentElectric,
        action: (() -> Void)? = nil
    ) -> some View {
        Group {
            if let action {
                Button(action: action) {
                    rowContent(icon, title, value: value, color: color)
                }
            } else {
                rowContent(icon, title, value: value, color: color)
            }
        }
    }

    private func rowContent(
        _ icon: String,
        _ title: String,
        value: String? = nil,
        color: Color
    ) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(title)
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textPrimary)
            Spacer()
            if let value {
                Text(value)
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(JQColors.textTertiary)
            }
        }
    }
}

#Preview {
    let state = AppState()
    state.userProfile = MockData.user

    return SettingsView()
        .environmentObject(state)
        .preferredColorScheme(.dark)
}
