import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                Dashboard()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            Friends()
                .tabItem {
                    Label("Friends", systemImage: "person.2.wave.2")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
