import SwiftUI

struct Stylesheet {
    var dashboardBackgroundColor = Color(white: 0.97)
    var stepColor = Color.blue
    var heartColor = Color.green
    var likeColor = Color.blue

    static let light = Stylesheet()
    static let dark = Stylesheet(
        dashboardBackgroundColor: Color(white: 0.2),
        stepColor: .orange,
        heartColor: .purple,
        likeColor: .red
    )
}

struct StylesheetKey: EnvironmentKey {
    static let defaultValue = Stylesheet.light
}

extension EnvironmentValues {
    var stylesheet: Stylesheet {
        get { self[StylesheetKey.self] }
        set { self[StylesheetKey.self] = newValue }
    }
}

struct UseStylesheet: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .environment(\.stylesheet, colorScheme == .light ? .light : .dark)
    }
}

extension View {
    func useStylesheet() -> some View {
        modifier(UseStylesheet())
    }
}
