//
//  RequiredFieldsValidation.swift
//  Validation
//
//  Created by Matheus Lima Gomes on 23/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

 public final class RequiredFieldsValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    
   public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
   public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
            !fieldName.isEmpty else { return "O Campo \(fieldLabel) é obrigatório" }
        return nil
    }
}
