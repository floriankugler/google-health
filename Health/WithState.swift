import SwiftUI

struct WithState<Value, Content: View>: View {
    @ViewBuilder var content: (Binding<Value>) -> Content
    @State private var value: Value

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = .init(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
