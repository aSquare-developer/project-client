//
//  project_clientApp.swift
//  project-client
//
//  Created by Artur Anissimov on 10.04.2025.
//

import SwiftUI

@main
struct project_clientApp: App {
    
    @StateObject private var model = DroppieModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                WelcomeScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            WelcomeScreen()
                        case .register:
                            WelcomeScreen()
                        case .main:
                            Main()
                        }
                    }
            }
            .environmentObject(model)
            .environmentObject(appState)
        }
    }
    
}
