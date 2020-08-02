//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Matheus Lima Gomes on 26/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//


import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email",
                          emailValidator: emailValidatorSpy,
                          fieldLabel: "Email")
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email":"invalid_email@domain.com"])
        XCTAssertEqual(errorMessage, "O campo Email é invalido")
    }
    func test_validate_should_return_error_if_correct_fieldLabel() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", emailValidator: emailValidatorSpy,
                          fieldLabel: "Email2")
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email":"invalid_email@domain.com"])
        XCTAssertEqual(errorMessage, "O campo Email2 é invalido")
    }
    func test_validate_should_return_nil_if_valid_email_is_provided() throws {
        let sut = makeSut(fieldName: "email", emailValidator: EmailValidatorSpy(),
                          fieldLabel: "Email2")
        let errorMessage = sut.validate(data: ["email":"valid_email@domain.com"])
        XCTAssertNil(errorMessage)
    }
    func test_validate_should_return_nil_if_no_data_is_provided () throws {
        let sut = makeSut(fieldName: "email", emailValidator: EmailValidatorSpy(),
                          fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é invalido")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String, emailValidator: EmailValidatorSpy, fieldLabel: String,
                 file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName,
                                  fieldLabel: fieldLabel,
                                  emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
