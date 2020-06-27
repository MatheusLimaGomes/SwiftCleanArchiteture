//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

public class EmailValidatorSpy: EmailValidator {
    var email: String?
    var isValid: Bool = true
    
    public func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    public func simulateInvalidEmail() {
        isValid = false
    }
}
