import SwiftUI

struct ProgressCircle: View {
    var value: CGFloat

    var body: some View {
        ZStack {
            let style = StrokeStyle(lineWidth: 5, lineCap: .round)
            Circle()
                .stroke(style: style)
                .opacity(0.15)
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: style)
        }
        .rotationEffect(.degrees(-90))
    }
}

struct Dashboard: View {
    @Environment(\.stylesheet) private var stylesheet

    var indicator: some View {
        ProgressCircle(value: 0.7)
            .foregroundColor(stylesheet.heartColor)
            .overlay {
                ProgressCircle(value: 0.3)
                    .foregroundColor(stylesheet.stepColor)
                    .padding(12)
            }
            .overlay {
                VStack {
                    Text("133")
                        .font(.title.bold())
                        .foregroundColor(stylesheet.heartColor)
                    Text("2496")
                        .font(.footnote.bold())
                        .foregroundColor(stylesheet.stepColor)
                }
            }
    }

    var indicatorLegend: some View {
        HStack(spacing: 10) {
            HStack(spacing: 3) {
                Image(systemName: "heart")
                    .foregroundColor(stylesheet.heartColor)
                Text("Heart Pts")
            }
            HStack(spacing: 3) {
                Image(systemName: "shoeprints.fill")
                    .foregroundColor(stylesheet.stepColor)
                Text("Steps")
            }
            .badgeIndicator(3)
        }
        .font(.footnote.weight(.medium))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                NavigationLink(destination: Detail()) {
                    indicator
                        .frame(width: 120, height: 120)
                }
                indicatorLegend
                Card {
                    Text("Check your heart rate")
                } content: {
                    Text("Did you know that things like dehydration can affect your heart rate? Measure yours at any time using just your phone.")
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(stylesheet.dashboardBackgroundColor)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
            .useStylesheet()
    }
}
