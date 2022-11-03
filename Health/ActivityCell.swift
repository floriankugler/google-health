import SwiftUI

extension ActivityType {
    var symbol: Image {
        switch self {
        case .run: return Image(systemName: "figure.run")
        case .ride: return Image(systemName: "figure.outdoor.cycle")
        case .hike: return Image(systemName: "figure.hiking")
        }
    }
}

struct ActivityCell: View {
    var activity: ActivityItem
    @Environment(\.stylesheet.likeColor) private var likeColor

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                image
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(Text(activity.user.name).fontWeight(.bold)) completed a \(activity.type.rawValue)")
                    HStack(alignment: .firstTextBaseline) {
                        activity.type.symbol
                        Text(activity.date, style: .date)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "heart")
                            .symbolVariant(activity.liked ? .fill : .none)
                            .foregroundColor(likeColor)
                    }
                }
            }
            .font(.footnote)
        }
    }

    @ViewBuilder var image: some View {
        RemoteImage(url: activity.user.imageURL, placeholder: { Color.gray })
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

struct ActivityCellPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ActivityCell(activity: ActivityItem.sample[0])
            ActivityCell(activity: ActivityItem.sample[1])
        }
        .padding()
        .useStylesheet()
    }
}
