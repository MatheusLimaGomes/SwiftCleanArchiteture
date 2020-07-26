//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Matheus Lima Gomes on 23/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
              let fieldNameToCompare = data?[fieldNameToCompare] as? String,
              fieldName == fieldNameToCompare else { return "O Campo \(fieldLabel) é inválido." }
        return nil
    }
}
