//
//  SignupPresenter.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 05/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Presentation




class SignupPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(passwordConfirmation: "invalid-password"))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "As senhas não coincidem"))
    }
    
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided () throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        emailValidatorSpy.isValid = false
        sut.signUp(makeSignUpViewModel())
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email Inválido"))
        
    }
    
    func test_signUp_should_call_email_validator_with_correct_email () throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut( emailValidator: emailValidatorSpy)
        let signUpViewModel = SignUpViewModel(name: "any name", email: "any-email@domain.com", password: "secret", passwordConfirmation: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email )
    }
}

extension SignupPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) ->  SignUpPresenter {
        return SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
    }
    func makeSignUpViewModel(name: String? = "any name",
                             email: String? = "any-email@domain.com", password: String? = "secret", passwordConfirmation: String? = "secret" ) -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    class EmailValidatorSpy: EmailValidator {
        var email: String?
        var isValid: Bool = true
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            
            self.viewModel = viewModel
            
        }
    }
}
