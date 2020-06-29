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
    func test_save_button_calls_SignUp_on_tap () throws {
        var signUpViewModel: SignUpViewModel?
        let sut = makeSut( { signUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        
        let name = sut.nameTextField?.text 
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConfirmation = sut.passwordConfirmationTextField?.text
        
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name,
                                                        email: email,
                                                        password: password,
                                                        passwordConfirmation: passwordConfirmation))
    }
}
extension SignUpViewControllerTests {
    func makeSut(_ signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instantiate()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
