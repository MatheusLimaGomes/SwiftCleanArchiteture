//
//  CompareFieldValidationTests.swift
//  ValidationTests
//
//  Created by Matheus Lima Gomes on 26/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Presentation
import Validation

class CompareFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_fields_not_match() throws {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare:"passwordConfirmation")
        let message = sut.validate(data: ["password": "123","passwordConfirmation": "32" ])
        XCTAssertEqual(message, "O Campo Senha é inválido.")
    }
    func test_validate_should_return_error_if_correct_field_label() throws {
        let sut = makeSut(fieldName: "password", fieldLabel: "Confirmar Senha", fieldNameToCompare:"passwordConfirmation")
        let message = sut.validate(data: ["password": "123","passwordConfirmation": "32" ])
        XCTAssertEqual(message, "O Campo Confirmar Senha é inválido.")
    }
    
    func test_validate_should_return_nil_if_field_succeeds() throws {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare:"passwordConfirmation")
        let message = sut.validate(data: ["password": "123","passwordConfirmation": "123" ])
        XCTAssertNil(message)
    }
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldNameToCompare:"passwordConfirmation")
        let message = sut.validate(data: nil)
        XCTAssertEqual(message, "O Campo Senha é inválido.")
    }
}
extension CompareFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String,
                 fieldNameToCompare: String,
                 file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName,
                                          fieldLabel: fieldLabel,
                                          fieldNameToCompare: fieldNameToCompare)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
