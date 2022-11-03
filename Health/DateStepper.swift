import SwiftUI

struct Interval {
    var date: Date
    var range: DateRange
}

enum DateRange: String, CaseIterable, Hashable {
    case day
    case week
    case month
}

struct DateRangePicker: View {
    @Binding var interval: Interval

    var body: some View {
        VStack(spacing: 0) {
            StylableSimplePicker(items: DateRange.allCases, id: \.self, selection: $interval.range, view: { r in
                Text(r.rawValue.capitalized)
                    .tag(r)
            })
            .zIndex(1)

            Rectangle()
                .foregroundColor(.primary.opacity(0.3))
                .frame(height: 1)
                .padding(.bottom, 10)
                .offset(y: -1)

            VStack {
                switch interval.range {
                case .day:
                    DateStepper(value: $interval.date.day) {
                        Text(interval.date, style: .date)
                    }

                case .week:
                    DateStepper(value: $interval.date.week) {
                        Text(interval.date.week.start...interval.date.week.end)
                    }
                case .month:
                    DateStepper(value: $interval.date.month) {
                        Text(interval.date.month.pretty)
                    }
                }
            }
            .padding(.horizontal)
        }
        .font(.footnote)
    }
}

struct DateStepper<Value: Strideable, LabelView: View>: View {
    @Binding var value: Value
    @ViewBuilder var label: LabelView

    var body: some View {
        HStack {
            Button(action: {
                value = value.advanced(by: -1)
            }, label: {
                Image(systemName: "chevron.left")
            })
            Spacer()
            label
            Spacer()
            Button(action: {
                value = value.advanced(by: 1)
            }, label: {
                Image(systemName: "chevron.right")
            })
        }
    }
}

struct MyStepper_Previews: PreviewProvider {
    static var previews: some View {
        WithState(Interval(date: Date(), range: .week)) { interval in
            DateRangePicker(interval: interval)
        }
    }
}
