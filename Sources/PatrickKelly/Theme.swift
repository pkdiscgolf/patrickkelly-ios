import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Colors lifted directly from patrickkelly.info's CSS variables.
enum Theme {
    static let bg = Color(hex: 0xF7F5F0)          // --bg
    static let bgAlt = Color(hex: 0xEFECE4)       // --bg-alt
    static let text = Color(hex: 0x22281F)        // --text
    static let textMuted = Color(hex: 0x5B5F56)   // --text-muted
    static let accent = Color(hex: 0x1F3D2E)      // --accent
    static let accentLight = Color(hex: 0x3A5A40) // --accent-light
    static let border = Color(hex: 0xDDD8CC)      // --border
    static let onAccent = Color(hex: 0xF4F1EA)    // button text
    static let card = Color.white

    static let cardRadius: CGFloat = 10
    static let buttonRadius: CGFloat = 6
    static let gutter: CGFloat = 20
}

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

/// Loads a PNG bundled in Resources/.
struct BundledImage: View {
    let name: String

    var body: some View {
        #if canImport(UIKit)
        if let path = Bundle.module.path(forResource: name, ofType: "png"),
           let ui = UIImage(contentsOfFile: path) {
            Image(uiImage: ui).resizable()
        } else {
            Theme.bgAlt
        }
        #else
        Theme.bgAlt
        #endif
    }
}

// MARK: - Reusable styles

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Theme.onAccent)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: Theme.buttonRadius)
                    .fill(configuration.isPressed ? Theme.accentLight : Theme.accent)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Theme.text)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: Theme.buttonRadius)
                    .strokeBorder(configuration.isPressed ? Theme.text : Theme.border, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: Theme.buttonRadius).fill(Theme.bg))
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

/// Card press feedback that mirrors the site's hover lift.
struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

struct Pill: View {
    let text: String
    var filled: Bool = false
    var large: Bool = false

    var body: some View {
        Text(text)
            .font(.system(size: large ? 14 : 12, weight: .medium))
            .foregroundStyle(Theme.accent)
            .padding(.horizontal, large ? 14 : 10)
            .padding(.vertical, large ? 6 : 3)
            .background(Capsule().fill(filled ? Theme.card : Theme.bgAlt))
            .overlay(Capsule().strokeBorder(Theme.border, lineWidth: 1))
    }
}

/// Wrapping row layout for pills.
struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, rowHeight: CGFloat = 0, maxX: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x > 0 && x + size.width > width {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            x += size.width + spacing
            maxX = max(maxX, x - spacing)
            rowHeight = max(rowHeight, size.height)
        }
        return CGSize(width: maxX, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x > bounds.minX && x + size.width > bounds.maxX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

struct SectionHeader: View {
    let title: String
    var subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Theme.text)
            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 16))
                    .foregroundStyle(Theme.textMuted)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Branded top bar content: logo + name, like the site header.
struct BrandToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack(spacing: 10) {
                BundledImage(name: "pk_logo")
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Text("Patrick Kelly")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Theme.text)
            }
            .accessibilityElement(children: .combine)
        }
    }
}

extension View {
    /// Apply the site's frosted cream header look to a navigation bar.
    func brandedNavigationBar() -> some View {
        #if os(iOS)
        return self
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Theme.bg.opacity(0.9), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar { BrandToolbar() }
        #else
        return self.toolbar { BrandToolbar() }
        #endif
    }
}
