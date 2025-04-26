import Foundation

struct RouteResponseDTO: Codable, Error {
    let error: Bool
    var reason: String? = nil
}
