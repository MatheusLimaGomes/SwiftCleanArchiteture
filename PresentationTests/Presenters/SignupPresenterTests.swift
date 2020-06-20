//
//  SignupPresenter.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 05/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Presentation
import Domain



class SignupPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModelIfRequiredField(field: "nome"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel,makeAlertViewModelIfRequiredField(field: "email"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModelIfRequiredField(field: "password") )
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModelIfRequiredField(field: "Confirmar Senha"))
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
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(makeSignUpViewModel())
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Email Inválido"))
        
    }
    
    func test_signUp_should_call_email_validator_with_correct_email () throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut( emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email )
    }
    func test_signUp_should_call_email_validator_with_correct_values () throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails () throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        sut.signUp(makeSignUpViewModel())
        addAccountSpy.completesWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.viewModel,
                       makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
        
    }
}

extension SignupPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy()) ->  SignUpPresenter {
        return SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount )
    }
    func makeSignUpViewModel(name: String? = "Nome do usuário completo",
                             email: String? = "emailusuari@dominio.com", password: String? = "3456178", passwordConfirmation: String? = "3456178") -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    func makeAlertViewModelIfRequiredField(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(field) é obrigatório")
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro!", message: message)
    }
    class EmailValidatorSpy: EmailValidator {
        var email: String?
        var isValid: Bool = true
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        func simulateInvalidEmail() {
            isValid = false
        }
    }
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            
            self.viewModel = viewModel
            
        }
    }
    class AddAccountSpy: AddAccount{
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        func completesWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
}
