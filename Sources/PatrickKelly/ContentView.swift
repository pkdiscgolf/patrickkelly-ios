import SwiftUI

enum AppTab: Hashable {
    case home, work, skills, contact
}

struct ContentView: View {
    @State private var tab: AppTab = .home
    @State private var browserURL: URL?

    var body: some View {
        TabView(selection: $tab) {
            NavigationStack {
                HomeView(tab: $tab)
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(AppTab.home)

            NavigationStack {
                WorkView(browserURL: $browserURL, tab: $tab)
            }
            .tabItem { Label("Work", systemImage: "square.grid.2x2") }
            .tag(AppTab.work)

            NavigationStack {
                SkillsView()
            }
            .tabItem { Label("Skills", systemImage: "wrench.and.screwdriver") }
            .tag(AppTab.skills)

            NavigationStack {
                ContactView(browserURL: $browserURL)
            }
            .tabItem { Label("Contact", systemImage: "envelope") }
            .tag(AppTab.contact)
        }
        .tint(Theme.accent)
        .sensoryFeedback(.selection, trigger: tab)
        .sheet(item: $browserURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
        // The website has a single light, cream palette; keep the app on-brand.
        .preferredColorScheme(.light)
    }
}

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}

#Preview {
    ContentView()
}
