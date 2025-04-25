//
//  Main.swift
//  project-client
//
//  Created by Artur Anissimov on 15.04.2025.
//

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
    }
}


#Preview {
    Main()
}
