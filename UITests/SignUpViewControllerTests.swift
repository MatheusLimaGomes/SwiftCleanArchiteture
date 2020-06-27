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
        var callsCount = 0
        let sut = makeSut( { _ in
            callsCount += 1
        })
        sut.saveButton?.simulateTap()
        XCTAssertEqual(callsCount, 1)
    }
}
extension SignUpViewControllerTests {
    func makeSut(_ signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController{
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
extension UIControl {
    private func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach{ action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
