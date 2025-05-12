import Foundation

struct RouteObject: Codable, Identifiable {
    let id: String
    let user: User
    let origin: String
    let destination: String
    let description: String
    let speedometerStart: Double
    let speedometerEnd: Double
    let distance: Double
    let date: Date
    let createdAt: Date
    let updatedAt: Date
}
