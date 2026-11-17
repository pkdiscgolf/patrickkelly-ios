import SwiftUI

struct HomeView: View {
    @Binding var tab: AppTab

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                hero
                    .padding(.horizontal, Theme.gutter)
                    .padding(.top, 40)
                    .padding(.bottom, 48)

                about
                    .padding(.horizontal, Theme.gutter)
                    .padding(.vertical, 48)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.bgAlt)

                featured
                    .padding(.vertical, 48)
            }
        }
        .background(Theme.bg)
        .brandedNavigationBar()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: Content.siteURL) {
                    Image(systemName: "square.and.arrow.up")
                }
                .tint(Theme.accent)
            }
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Content.eyebrow.uppercased())
                .font(.system(size: 13, weight: .semibold))
                .tracking(1.5)
                .foregroundStyle(Theme.accentLight)
                .padding(.bottom, 16)

            Text(Content.heroTitle)
                .font(.system(size: 34, weight: .bold))
                .lineSpacing(2)
                .foregroundStyle(Theme.text)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 20)

            Text(Content.heroSub)
                .font(.system(size: 17))
                .lineSpacing(5)
                .foregroundStyle(Theme.textMuted)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 32)

            VStack(spacing: 12) {
                Button("See My Work") { tab = .work }
                    .buttonStyle(PrimaryButtonStyle())
                Button("Get In Touch") { tab = .contact }
                    .buttonStyle(SecondaryButtonStyle())
            }
        }
    }

    private var about: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "About")
            Text(Content.about)
                .font(.system(size: 17))
                .lineSpacing(5)
                .foregroundStyle(Theme.textMuted)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var featured: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text("Recent Work")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Theme.text)
                Spacer()
                Button {
                    tab = .work
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right").font(.system(size: 12, weight: .semibold))
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Theme.accentLight)
                }
            }
            .padding(.horizontal, Theme.gutter)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(Content.projects.prefix(4)) { project in
                        Button { tab = .work } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                BundledImage(name: project.image)
                                    .scaledToFill()
                                    .frame(width: 240, height: 150, alignment: .top)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Theme.cardRadius)
                                            .strokeBorder(Theme.border, lineWidth: 1)
                                    )
                                Text(project.name)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(Theme.text)
                                Text(project.displayURL)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Theme.accentLight)
                            }
                            .frame(width: 240, alignment: .leading)
                        }
                        .buttonStyle(CardButtonStyle())
                    }
                }
                .padding(.horizontal, Theme.gutter)
            }
        }
    }
}
