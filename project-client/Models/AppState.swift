import Foundation

enum Route: Hashable {
    case login
    case register
    case main
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
