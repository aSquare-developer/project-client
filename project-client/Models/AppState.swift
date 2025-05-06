import Foundation

enum Route: Hashable {
    case login
    case register
    case main
}

enum DroppieError: Error {
    case login
    case register
    case fieldsIsInvalid
    case saveRouteError
    case successfullyAddedRoute
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper?
    @Published var notificationWrapper: NotificationWrapper?
}
