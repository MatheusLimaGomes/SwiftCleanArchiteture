//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 22/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String: Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    func simulateError() {
        self.errorMessage = "Erro"
    }
}
