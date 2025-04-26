//
//  UserDefaults+Extensions.swift
//  project-client
//
//  Created by Artur Anissimov on 27.04.2025.
//

import Foundation

extension UserDefaults {
    
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdAsString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}
