//
//  SignupPresenter.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 05/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest

class SignUpPresenter {
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    func signUp(_ viewModel: SignUpViewModel) {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório"))
        }
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

class SignupPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(email: "email@email.com", password: "secret", passwordConfirmation: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório"))
    }
}

extension SignupPresenterTests {
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            
            self.viewModel = viewModel
            
        }
    }
}