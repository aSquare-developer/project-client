import SwiftUI

struct Main: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Маршрут")
                }

            Text("История")
                .tabItem {
                    Image(systemName: "clock")
                    Text("История")
                }

            Text("Профиль")
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    Main()
}
