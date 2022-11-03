import SwiftUI

struct Detail: View {
    @State private var interval = Interval(date: Date(), range: .week)

    var body: some View {
        VStack(spacing: 30) {
            DateRangePicker(interval: $interval)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.primary.opacity(0.05))
                Text("Selected date interval: \nrange: \(interval.range.rawValue)\nday: \(interval.date, style: .date)")
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail()
    }
}
