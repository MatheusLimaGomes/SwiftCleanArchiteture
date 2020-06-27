//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: Model {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil,
                password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
