import SwiftUI

struct Card<Title: View, Content: View>: View {
    @ViewBuilder var title: Title
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
                .bold()
            content
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(.background)
                .shadow(color: .primary.opacity(0.2), radius: 3, y: 2)
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark")
                .padding(15)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
        .font(.footnote)
    }
}

