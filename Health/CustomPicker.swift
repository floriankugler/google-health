import SwiftUI

public struct CustomPicker<Item: Hashable, ID: Hashable, V: View>: View {
    init(items: [Item], id: KeyPath<Item, ID>, selection: Binding<Item>, @ViewBuilder view: @escaping (Item) -> V) {
        self.items = items
        self.id = id
        self.view = view
        self._selection = selection
    }

    var items: [Item]
    var id: KeyPath<Item, ID>
    var view: (Item) -> V
    @Binding var selection: Item
    @Namespace private var namespace

    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                ForEach(items, id: id) { item in
                    let isSelected = selection[keyPath: id] == item[keyPath: id]
                    VStack {
                        view(item)
                            .foregroundColor(isSelected ? .accentColor : .secondary)
                            .contentShape(Rectangle())
                            .padding(.bottom, 10)
                            .overlay(alignment: .bottom) {
                                if isSelected {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.accentColor)
                                }
                            }
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
    init(items: [Item], selection: Binding<Item>, @ViewBuilder view: @escaping (Item) -> V) {
        self.items = items
        self.id = \Item.id
        self.view = view
        self._selection = selection
    }
}

enum Mailbox: CaseIterable, Hashable, Identifiable {
    case inbox
    case spam

    var id: Self { self }
}

var sample: some View {
    VStack {
        WithState("Inbox") { $binding in
            CustomPicker(items: ["Inbox", "Two", "Three"], id: \.self, selection: $binding, view: { Text($0) })
        }
        WithState(Mailbox.inbox) { $value in
            CustomPicker(items: Mailbox.allCases, selection: $value) { box in
                switch box {
                case .inbox: Label("Inbox", systemImage: "tray")
                case .spam: Label("Spam", systemImage: "tray.fill")
                }
            }
        }
    }
    .padding()
}

struct CustomPickerPreview: PreviewProvider {
    static var previews: some View {
        sample
    }
}
