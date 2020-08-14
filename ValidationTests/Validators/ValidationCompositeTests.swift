//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Matheus Lima Gomes on 02/08/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//


import XCTest
import Presentation
import Validation

class ValidationComposite: Validation {
    private let validations: [Validation]
    init(validations: [Validation]) {
        self.validations = validations 
    }
    func validate(data: [String : Any]?) -> String? {
        return nil
    }
    
    
}
class ValidationSpy: Validation {
    func validate(data: [String : Any]?) -> String? {
        return nil
    }
}
class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() throws {
        let validationSpy = ValidationSpy()
        let sut = ValidationComposite(validations: [validationSpy])
        let errorMessage = sut.validate(data: ["":""])
    }
}
