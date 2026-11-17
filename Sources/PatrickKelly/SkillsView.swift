import SwiftUI

struct SkillsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeader(title: "Skills & Experience")

                ForEach(Content.skillGroups) { group in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 10) {
                            Image(systemName: group.icon)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Theme.accentLight)
                                .frame(width: 32, height: 32)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Theme.bgAlt))
                            Text(group.title)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(Theme.text)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(group.items, id: \.self) { item in
                                HStack(alignment: .firstTextBaseline, spacing: 10) {
                                    Circle()
                                        .fill(Theme.accentLight)
                                        .frame(width: 5, height: 5)
                                        .alignmentGuide(.firstTextBaseline) { $0[.bottom] + 4 }
                                    Text(item)
                                        .font(.system(size: 15))
                                        .foregroundStyle(Theme.textMuted)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.card)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.cardRadius)
                            .strokeBorder(Theme.border, lineWidth: 1)
                    )
                }

                Text("Tech Stack")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Theme.text)
                    .padding(.top, 16)

                FlowLayout(spacing: 10) {
                    ForEach(Content.techStack, id: \.self) {
                        Pill(text: $0, filled: true, large: true)
                    }
                }
            }
            .padding(.horizontal, Theme.gutter)
            .padding(.vertical, 24)
        }
        .background(Theme.bg)
        .brandedNavigationBar()
    }
}
