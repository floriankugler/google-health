import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    var image: String
}

enum ActivityType: String, Codable {
    case run = "run"
    case ride = "bike ride"
    case hike = "hike"
}

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    var user: User
    var type: ActivityType
    var date: Date
    var liked: Bool
}

extension User {
    static let sample = User(name: "Kate Appleseed", image: "image0.jpg")
    static let sample2 = User(name: "John Bell", image: "image1.jpg")
    
    var imageURL: URL {
        baseURL.appendingPathComponent(image)
    }
}

let baseURL: URL = URL(string: "https://d2sazdeahkz1yk.cloudfront.net/sample/google-health/")!

extension ActivityItem {
    static let sample: [ActivityItem] = [
        .init(user: .sample, type: .run, date: .now.addingTimeInterval(-3600), liked: false),
        .init(user: .sample2, type: .run, date: .now.addingTimeInterval(-1*24*3600), liked: true),
        .init(user: .sample, type: .ride, date: .now.addingTimeInterval(-2*24*3600), liked: false),
        .init(user: .sample2, type: .run, date: .now.addingTimeInterval(-3*24*3600), liked: true),
        .init(user: .sample, type: .hike, date: .now.addingTimeInterval(-4*24*3600), liked: false),
        .init(user: .sample2, type: .hike, date: .now.addingTimeInterval(-5*24*3600), liked: true),
        .init(user: .sample, type: .run, date: .now.addingTimeInterval(-6*24*3600), liked: false),
        .init(user: .sample2, type: .ride, date: .now.addingTimeInterval(-7*24*3600), liked: true),
    ]
    
}
