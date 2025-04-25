//
//  String+Extensions.swift
//  project-client
//
//  Created by Artur Anissimov on 20.04.2025.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
