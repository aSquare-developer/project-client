import Foundation

struct Constants {
    
    private static let baseUrlPath = "http://192.168.1.140:8080/api"
    
    struct Urls {
        static let register = URL(string: "\(baseUrlPath)/register")!
        static let login = URL(string: "\(baseUrlPath)/login")!
        
        static func saveRouteByUserId(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/route")!
        }
        
        static func getRoutesByUserId(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/routes")!
        }
    }
}
