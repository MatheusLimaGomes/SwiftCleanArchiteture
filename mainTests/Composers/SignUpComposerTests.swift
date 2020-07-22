//
//  SignUpComposerTests.swift
//  mainTests
//
//  Created by Matheus Lima Gomes on 15/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import main
import UI

class SignUpComposerTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "wating")
        DispatchQueue.global().async {
            addAccountSpy.completesWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccount: AddAccountSpy) {
        let addAccount = AddAccountSpy()
        let sut = SignUpComposer.composeControllerWith(DispatchMainQueueDecorator(addAccount))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccount, file: file, line: line)
        return (sut, addAccount)
    }
}
