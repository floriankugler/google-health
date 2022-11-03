import SwiftUI

struct MaxWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension View {
    func measureMaxWidth() -> some View {
        self.overlay(GeometryReader { proxy in
            Color.clear.preference(key: MaxWidthKey.self, value: proxy.size.width)
        })
    }
}
