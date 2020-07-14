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
        let sut = EmailValidatorAdapter()
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
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "first@domain.com"))
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
