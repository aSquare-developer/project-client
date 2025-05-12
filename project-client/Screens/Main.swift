import SwiftUI

struct Main: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Routes")
                }

            Text("History")
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    Main()
}
