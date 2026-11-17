import SwiftUI

struct WorkView: View {
    @Binding var browserURL: URL?
    @Binding var tab: AppTab

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader(title: "Selected Work",
                              subtitle: "A few of the projects I've designed and built.")

                LazyVStack(spacing: 20) {
                    ForEach(Content.projects) { project in
                        Button {
                            browserURL = project.url
                        } label: {
                            WorkCard(project: project)
                        }
                        .buttonStyle(CardButtonStyle())
                        .contextMenu {
                            Button {
                                browserURL = project.url
                            } label: {
                                Label("Open", systemImage: "safari")
                            }
                            Link(destination: project.url) {
                                Label("Open in Safari", systemImage: "arrow.up.forward.app")
                            }
                            ShareLink(item: project.url) {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        } preview: {
                            BundledImage(name: project.image)
                                .scaledToFit()
                                .frame(width: 340)
                        }
                    }

                    Button {
                        tab = .contact
                    } label: {
                        CTACard()
                    }
                    .buttonStyle(CardButtonStyle())
                }
            }
            .padding(.horizontal, Theme.gutter)
            .padding(.vertical, 24)
        }
        .background(Theme.bgAlt)
        .brandedNavigationBar()
    }
}

private struct WorkCard: View {
    let project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            BundledImage(name: project.image)
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .aspectRatio(16 / 10, contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .top)
                .clipped()
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Theme.border).frame(height: 1)
                }

            VStack(alignment: .leading, spacing: 10) {
                Text(project.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Theme.text)

                Text(project.summary)
                    .font(.system(size: 15))
                    .lineSpacing(4)
                    .foregroundStyle(Theme.textMuted)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                FlowLayout(spacing: 6) {
                    ForEach(project.stack, id: \.self) { Pill(text: $0) }
                }
                .padding(.top, 2)

                Text("\(project.displayURL) ↗")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Theme.accentLight)
                    .padding(.top, 2)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 4)
        }
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.cardRadius)
                .strokeBorder(Theme.border, lineWidth: 1)
        )
        .shadow(color: Theme.accent.opacity(0.06), radius: 8, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
        .accessibilityElement(children: .combine)
        .accessibilityHint("Opens \(project.displayURL)")
    }
}

private struct CTACard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("+")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(Theme.accentLight)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Theme.bgAlt)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Theme.border).frame(height: 1)
                }

            VStack(alignment: .leading, spacing: 10) {
                Text("Your Project?")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Theme.text)
                Text("Have an idea for an app or website? Let's build it together.")
                    .font(.system(size: 15))
                    .foregroundStyle(Theme.textMuted)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Get in touch ↗")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Theme.accentLight)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.cardRadius)
                .strokeBorder(Theme.border, lineWidth: 1)
        )
    }
}
