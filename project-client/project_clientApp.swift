import SwiftUI

@main
struct project_clientApp: App {
    
    @StateObject private var model = DroppieModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                
                Group {
                    if token == nil {
                        WelcomeScreen()
                    } else {
                        Main()
                    }
                }
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
