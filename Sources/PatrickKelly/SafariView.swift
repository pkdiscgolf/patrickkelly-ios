import SwiftUI

#if canImport(SafariServices) && os(iOS)
import SafariServices

/// In-app browser for project sites and social links.
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = UIColor(Theme.accent)
        vc.preferredBarTintColor = UIColor(Theme.bg)
        vc.dismissButtonStyle = .done
        return vc
    }

    func updateUIViewController(_ vc: SFSafariViewController, context: Context) {}
}
#else
struct SafariView: View {
    let url: URL
    var body: some View { Link(url.absoluteString, destination: url) }
}
#endif
