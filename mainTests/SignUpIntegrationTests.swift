//
//  SignUpIntegrationTests.swift
//  mainTests
//
//  Created by Matheus Lima Gomes on 15/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import main

class SignUpIntegrationTests: XCTestCase {
    func test_ui_presentation_integration() throws {
        debugPrint("==================$==================$==================$")
        debugPrint("\(Environment.variable(.apiBaseUrl))")
        debugPrint("==================$==================$==================$")
        let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
