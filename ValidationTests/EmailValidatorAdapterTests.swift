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

public final class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
