import SwiftUI

struct AnimatedUnderlineStyleCell: ViewModifier {
    var isSelected: Bool
    var namespace: Namespace.ID

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .padding(.bottom, 10)
            .overlay(alignment: .bottom) {
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "Selection", in: namespace)
                }
            }
            .foregroundColor(isSelected ? .accentColor : .secondary)
    }
}

public struct AnimatedUnderlineStyle: CustomPickerStyle {
    public func body(configuration: Configuration) -> some View {
        configuration.label
            .modifier(AnimatedUnderlineStyleCell(isSelected: configuration.isSelected, namespace: configuration.namespace))

    }
}

extension CustomPickerStyle where Self == AnimatedUnderlineStyle {
    static var animatedUnderline: Self {
        AnimatedUnderlineStyle()
    }
}

struct AnimatedUnderlineStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WithState("One") { $state in
                StylableSimplePicker(items: ["One", "Two", "Three"], id: \.self, selection: $state, view: {
                    Text($0)
                })
                .animation(.default, value: state)
                .customPickerStyle(.animatedUnderline)
            }
        }
    }
}
