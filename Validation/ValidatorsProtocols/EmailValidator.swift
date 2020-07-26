//
//  EmailValidator.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 08/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
