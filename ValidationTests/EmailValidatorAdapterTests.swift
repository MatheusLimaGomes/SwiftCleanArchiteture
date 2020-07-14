//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Matheus Lima Gomes on 13/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Presentation

class EmailValidatorAdapterTests: XCTestCase {
    
    func test_invalidEmails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@."))
        XCTAssertFalse(sut.isValid(email: "rr@@"))
        XCTAssertFalse(sut.isValid(email: "@rr.2"))
        XCTAssertFalse(sut.isValid(email: "123"))
        XCTAssertFalse(sut.isValid(email: "r@r.2"))
        XCTAssertFalse(sut.isValid(email: "rr@w.c"))
        XCTAssertFalse(sut.isValid(email: "rr@domain.c"))
    }
    func test_validEmails() throws {
        XCTAssertTrue(makeSut().isValid(email: "first@domain.com"))
        XCTAssertTrue(makeSut().isValid(email: "first@domain.com.br"))
        XCTAssertTrue(makeSut().isValid(email: "first@domain.com.br.an"))
    }
}
extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
