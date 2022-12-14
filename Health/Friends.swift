import SwiftUI

struct Friends: View {
    @State private var items: [ActivityItem]?
    
    func loadData() async {
        do {
            try await Task.sleep(for: .seconds(1))
            let (data, _) = try await URLSession.shared.data(from: ActivityItem.url)
            items = try JSONDecoder().decode([ActivityItem].self, from: data)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            if let items {
                List(items) { item in
                    ActivityCell(activity: item)
                }
                .listStyle(.plain)
                .refreshable {
                    await loadData()
                }
            } else {
                ProgressView()
                    .task {
                        await loadData()
                    }
            }
        }
    }
}


struct Previews_Friends_Previews: PreviewProvider {
    static var previews: some View {
        Friends()
    }
}
