//
//  Validation.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 22/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
