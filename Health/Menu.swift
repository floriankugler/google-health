import SwiftUI

struct Menu: ViewModifier {
    @State private var showMenu = false

    var plusButton: some View {
        Button {
            showMenu.toggle()
        } label: {
            Image(systemName: "plus")
                .font(showMenu ? .body : .title.weight(.medium))
                .rotationEffect(.degrees(showMenu ? 45 : 0))
                .frame(width: 50, height: 50)
                .background {
                    Circle()
                        .foregroundStyle(.background)
                        .shadow(color: .primary.opacity(0.5), radius: 5, y: 3)
                }
        }
        .buttonStyle(.plain)
        .scaleUpAndDownEffect(count: showMenu ? 1 : 0)
    }

    @ViewBuilder
    var menu: some View {
        Label("Add sleep", systemImage: "sleep")
        Label("Add weight", systemImage: "scalemass")
        Label("Add activity", systemImage: "pencil")
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                if showMenu {
                    Rectangle()
                        .fill(.thinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showMenu = false
                        }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                VStack(alignment: .menuAlignment, spacing: 12) {
                    if showMenu {
                        menu
                            .labelStyle(MenuLabelStyle())
                    }
                    plusButton
                        .padding(.top, 12)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 60)
            }
            .animation(.default, value: showMenu)
    }
}

struct MenuLabelStyle: LabelStyle {
    func makeBody(configuration: LabelStyle.Configuration) -> some View {
        HStack(spacing: 0) {
            configuration.title
                .font(.footnote)
                .fixedSize()
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
            configuration.icon
                .font(.body)
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .padding(10)
                .background {
                    Circle()
                        .foregroundStyle(.background)
                        .shadow(color: .primary.opacity(0.5), radius: 5, y: 3)
                }
                .alignmentGuide(.menuAlignment) { $0[HorizontalAlignment.center] }
        }
    }
}

struct MenuAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static let menuAlignment = HorizontalAlignment(MenuAlignment.self)
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Color.yellow
            .modifier(Menu())
            .useStylesheet()
    }
}
