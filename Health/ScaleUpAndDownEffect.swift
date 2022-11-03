import SwiftUI

private struct ScaleUpAndDown: AnimatableModifier {
    var scale: CGFloat
    var count: CGFloat
    var animatableData: CGFloat {
        get { count }
        set { count = newValue }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(1 + abs(sin(.pi * count)) * (scale-1))
    }
}

extension View {
    func scaleUpAndDownEffect(scale: CGFloat = 1.2, count: Int) -> some View {
        return modifier(ScaleUpAndDown(scale: scale, count: CGFloat(count)))
    }
}
