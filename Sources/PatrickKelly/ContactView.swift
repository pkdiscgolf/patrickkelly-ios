import SwiftUI

struct ContactView: View {
    @Binding var browserURL: URL?
    @Environment(\.openURL) private var openURL
    @State private var copied = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader(title: "Get In Touch",
                              subtitle: "Have a project in mind? Let's talk about it.")

                VStack(spacing: 14) {
                    ContactRow(label: "Email", value: Content.email, icon: "envelope.fill") {
                        openURL(URL(string: "mailto:\(Content.email)")!)
                    } onCopy: {
                        copy(Content.email)
                    }

                    ContactRow(label: "Phone", value: Content.phoneDisplay, icon: "phone.fill") {
                        openURL(URL(string: "tel:\(Content.phoneDigits)")!)
                    } onCopy: {
                        copy(Content.phoneDisplay)
                    }
                }

                // iPhone quick actions
                HStack(spacing: 12) {
                    QuickAction(title: "Call", icon: "phone.fill") {
                        openURL(URL(string: "tel:\(Content.phoneDigits)")!)
                    }
                    QuickAction(title: "Text", icon: "message.fill") {
                        openURL(URL(string: "sms:\(Content.phoneDigits)")!)
                    }
                    QuickAction(title: "Email", icon: "envelope.fill") {
                        openURL(URL(string: "mailto:\(Content.email)")!)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Follow")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Theme.text)

                    VStack(spacing: 0) {
                        ForEach(Array(Content.socials.enumerated()), id: \.element.id) { index, social in
                            Button {
                                browserURL = social.url
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: social.icon)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(Theme.accentLight)
                                        .frame(width: 28)
                                    Text(social.name)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(Theme.text)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Theme.textMuted)
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 15)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)

                            if index < Content.socials.count - 1 {
                                Rectangle().fill(Theme.border).frame(height: 1)
                                    .padding(.leading, 58)
                            }
                        }
                    }
                    .background(Theme.card)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.cardRadius)
                            .strokeBorder(Theme.border, lineWidth: 1)
                    )
                }
                .padding(.top, 8)

                footer
                    .padding(.top, 24)
            }
            .padding(.horizontal, Theme.gutter)
            .padding(.vertical, 24)
        }
        .background(Theme.bgAlt)
        .brandedNavigationBar()
        .overlay(alignment: .bottom) {
            if copied {
                Text("Copied")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Theme.onAccent)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(Capsule().fill(Theme.accent))
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .sensoryFeedback(.success, trigger: copied) { _, new in new }
    }

    private var footer: some View {
        HStack(spacing: 8) {
            BundledImage(name: "pk_logo")
                .scaledToFit()
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            Text("© \(String(Calendar.current.component(.year, from: .now))) Patrick Kelly")
                .font(.system(size: 14))
                .foregroundStyle(Theme.textMuted)
            Spacer()
            Button("patrickkelly.info") { browserURL = Content.siteURL }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Theme.accentLight)
        }
    }

    private func copy(_ string: String) {
        #if canImport(UIKit)
        UIPasteboard.general.string = string
        #endif
        withAnimation(.spring(response: 0.3)) { copied = true }
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation(.easeOut) { copied = false }
        }
    }
}

private struct ContactRow: View {
    let label: String
    let value: String
    let icon: String
    let action: () -> Void
    let onCopy: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label.uppercased())
                        .font(.system(size: 13))
                        .tracking(0.5)
                        .foregroundStyle(Theme.textMuted)
                    Text(value)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Theme.text)
                }
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundStyle(Theme.onAccent)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Theme.accent))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Theme.card)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.cardRadius)
                    .strokeBorder(Theme.border, lineWidth: 1)
            )
        }
        .buttonStyle(CardButtonStyle())
        .contextMenu {
            Button(action: onCopy) { Label("Copy \(label)", systemImage: "doc.on.doc") }
        }
    }
}

private struct QuickAction: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 18))
                Text(title).font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(Theme.onAccent)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(RoundedRectangle(cornerRadius: Theme.cardRadius).fill(Theme.accent))
        }
        .buttonStyle(CardButtonStyle())
    }
}
