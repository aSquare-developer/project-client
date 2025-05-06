import Foundation

struct RouteRequestDTO: Codable {
    let origin: String
    let destination: String
    let date: Date
}
