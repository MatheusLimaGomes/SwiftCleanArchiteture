//
//  SignUpViewControllerTests .swift
//  UITests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import UIKit
import Presentation 
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    func test_sut_implements_Loading_view_protocol() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_Alert_view_protocol() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
}
extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController{
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as SignUpViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
