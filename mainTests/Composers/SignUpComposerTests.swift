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
    func test_background_should_complete_on_main_thread() throws {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
    }
}
extension SignUpComposerTests {
    func makeSut(addAccount: AddAccountSpy = AddAccountSpy(),  file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccount: AddAccountSpy) {
        let sut = SignUpComposer.composeControllerWith(addAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccount, file: file, line: line)
        return (sut, addAccount)
    }
}
