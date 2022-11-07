import SwiftUI

struct Badge: View {
    var count: Int
    @ScaledMetric(relativeTo: .footnote) private var indicatorHeight = 20

    var body: some View {
        Text("\(count)")
            .font(Font.footnote.monospacedDigit()).bold()
            .fixedSize()
            .padding(.horizontal, 5)
            .frame(height: indicatorHeight)
            .background {
                Capsule()
                    .fill(.orange)
                    .frame(minWidth: indicatorHeight)
            }
            .foregroundColor(.white)
    }
}

extension View {
    func badgeIndicator(_ count: Int, alignment: Alignment = .topTrailing) -> some View {
        overlay(alignment: alignment) {
            Badge(count: count)
                .alignmentGuide(alignment.horizontal, computeValue: { dim in
                    dim[HorizontalAlignment.center]
                }).alignmentGuide(alignment.vertical, computeValue: { dim in
                    dim[VerticalAlignment.center]
                })
                .opacity(count > 0 ? 1 : 0)
        }
    }
}

struct BadgePreviews: PreviewProvider {
    static var previews: some View {
        let view = Text("Hello")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).fill(.quaternary))
        VStack(spacing: 20) {
            view.badgeIndicator(3)
            view.badgeIndicator(30)
            view.badgeIndicator(99)
            view.badgeIndicator(999)
        }
    }
}
