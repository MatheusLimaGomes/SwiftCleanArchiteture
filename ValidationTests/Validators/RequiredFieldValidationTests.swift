//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by Matheus Lima Gomes on 22/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let message = sut.validate(data: ["name": "Matheus"])
        XCTAssertEqual(message, "O Campo Email é obrigatório")
    }
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let sut = makeSut(fieldName: "name", fieldLabel: "Name")
        let message = sut.validate(data: ["idade": "24"])
        XCTAssertEqual(message, "O Campo Name é obrigatório")
    }
    func test_validate_should_return_nil_if_field_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let message = sut.validate(data: ["email": "matheus.lima.gomes@outlook.com"])
        XCTAssertNil(message)
    }
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let message = sut.validate(data: nil)
        XCTAssertEqual(message, "O Campo Email é obrigatório")
    }
}
extension RequiredFieldValidationTests {
    func makeSut(fieldName: String,
                 fieldLabel: String,
                 file: StaticString = #file,
                 line: UInt = #line) -> Validation {
        let sut = RequiredFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
