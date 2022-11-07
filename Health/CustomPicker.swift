import Foundation
import SwiftUI

public struct Configuration {
    public var namespace: Namespace.ID
    public var isSelected: Bool
    public var label: AnyView
}

public protocol CustomPickerStyle {
    associatedtype Body: View
    func body(configuration: Configuration) -> Body
}

enum CustomPickerStyleKey: EnvironmentKey {
    static var defaultValue: any CustomPickerStyle { UnderlineStyle() }
}

extension EnvironmentValues {
    var customPickerStyle: any CustomPickerStyle {
        get { self[CustomPickerStyleKey.self] }
        set { self[CustomPickerStyleKey.self] = newValue }
    }
}

extension View {
    func customPickerStyle<S: CustomPickerStyle>(_ value: S) -> some View {
        environment(\.customPickerStyle, value)
    }
}

public struct UnderlineStyle: CustomPickerStyle {
    public func body(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isSelected ? .accentColor : .secondary)
            .contentShape(Rectangle())
            .padding(.bottom, 10)
            .overlay(alignment: .bottom) {
                if configuration.isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.accentColor)
                }
            }
    }
}

extension CustomPickerStyle where Self == UnderlineStyle {
    public static var underline: Self { Self() }
}

public struct SegmentedStyle: CustomPickerStyle {
    public func body(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(lineWidth: 2)
            }
            .foregroundColor(configuration.isSelected ? Color.accentColor : .secondary)
    }
}

extension CustomPickerStyle where Self == SegmentedStyle {
    public static var segmented: SegmentedStyle {
        SegmentedStyle()
    }
}

public struct CustomPicker<Item: Hashable, ID: Hashable, V: View>: View {
    var items: [Item]
    var id: KeyPath<Item, ID>
    @Binding var selection: Item
    var view: (Item) -> V
    @Namespace private var namespace
    @Environment(\.customPickerStyle) private var style

    init(items: [Item], id: KeyPath<Item, ID>, selection: Binding<Item>, view: @escaping (Item) -> V) {
        self.items = items
        self.id = id
        self.view = view
        self._selection = selection
    }

    public var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                ForEach(items, id: id) { item in
                    let isSelected = selection[keyPath: id] == item[keyPath: id]
                    VStack {
                        AnyView(style
                            .body(configuration: .init(namespace: namespace, isSelected: isSelected, label: .init(view(item)))))
                    }
                    .onTapGesture {
                        selection = item
                    }
                }
            }
        }
    }
}

public extension CustomPicker where Item: Identifiable, Item.ID == ID {
    init(items: [Item], view: @escaping (Item) -> V, selection: Binding<Item>) {
        self.items = items
        self.id = \Item.id
        self.view = view
        self._selection = selection
    }
}

struct StylableSimplePicker_Previews: PreviewProvider {
    static var previews: some View {
        WithState("One") { $state in
            let picker = CustomPicker(items: ["One", "Two", "Three"], id: \.self, selection: $state, view: {
                Text($0)
            })
            .padding()

            VStack {
                picker
                picker.customPickerStyle(.segmented)
            }
        }
    }
}
