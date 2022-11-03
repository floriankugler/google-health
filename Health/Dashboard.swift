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
    let stepColor = Color.blue
    let heartColor = Color.green
    
    var indicator: some View {
        ProgressCircle(value: 0.7)
            .foregroundColor(heartColor)
            .overlay {
                ProgressCircle(value: 0.3)
                    .foregroundColor(stepColor)
                    .padding(12)
            }
            .overlay {
                VStack {
                    Text("133")
                        .font(.title.bold())
                        .foregroundColor(heartColor)
                    Text("2496")
                        .font(.footnote.bold())
                        .foregroundColor(stepColor)
                }
            }
    }
    
    var indicatorLegend: some View {
        HStack(spacing: 10) {
            HStack(spacing: 3) {
                Image(systemName: "heart")
                    .foregroundColor(heartColor)
                Text("Heart Pts")
            }
            HStack(spacing: 3) {
                Image(systemName: "shoeprints.fill")
                    .foregroundColor(stepColor)
                Text("Steps")
            }
        }
        .font(.footnote.weight(.medium))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                indicator
                    .frame(width: 120, height: 120)
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
        .background(.primary.opacity(0.05))
    }
}


struct Previews_Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
