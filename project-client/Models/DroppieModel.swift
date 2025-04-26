import Foundation


/*
This model is to perform business logic.
Here we use our HTTP client to fetch the data and give it to the view.
      
This model usually called Aggregate Model
*/

class DroppieModel: ObservableObject {
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        
        let registerData = ["username": username, "password": password]
        
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        
        return registerResponseDTO
        
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        
        let loginData = ["username": username, "password": password]
        
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginData)), modelType: LoginResponseDTO.self)
        let loginResponseDTO = try await httpClient.load(resource)
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil && loginResponseDTO.userId != nil {
            // Save the token in user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: "authToken")
            defaults.set(loginResponseDTO.userId!.uuidString, forKey: "userId")
        }
        
        return loginResponseDTO
    }
    
    func saveRoute(_ routeRequestDTO: RouteRequestDTO) async throws -> RouteResponseDTO {
        
        let defaults = UserDefaults.standard
        guard let userIdString = defaults.string(forKey: "userId"),
              let userId = UUID(uuidString: userIdString)
        else {
            throw RouteResponseDTO(error: true, reason: "User ID not found.")
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(routeRequestDTO)
        
        // /api/users/:userId/route
        let resource = Resource(
            url: Constants.Urls.saveRouteByUserId(userId: userId),
            method: .post(data),
            modelType: RouteResponseDTO.self)
        
        let newRoute = try await httpClient.load(resource)
        
        return newRoute
    }
    
    
}
