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
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel,
                           self?.makeAlertViewModelIfRequiredField(field: "nome"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel,
                           self?.makeAlertViewModelIfRequiredField(field: "email"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel,
                           self?.makeAlertViewModelIfRequiredField(field: "password"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel,
                           self?.makeAlertViewModelIfRequiredField(field: "Confirmar Senha"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match () throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel,
                           self.makeErrorAlertViewModel(title: "Falha na validação", message: "As senhas não coincidem"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel(passwordConfirmation: "invalid-password"))
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided () throws {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(field: "Email"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_email_validator_with_correct_email () throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
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
        let exp = expectation(description: "wating")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel,
                           self?.makeErrorAlertViewModel(title: "Erro!",
                                                         message: "Algo inesperado aconteceu, tente novamente em alguns instantes"))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel())
        addAccountSpy.completesWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    func test_signUp_should_show_loading_before_call_addAccount () throws {
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(loadingView: loadingViewSpy)
        sut.signUp(makeSignUpViewModel())
        XCTAssertEqual(loadingViewSpy.viewModel, LoadingViewModel(isActive: true))
    }
}

extension SignupPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #file, line: UInt = #line) ->  SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line )
        return sut
    }
    func makeSignUpViewModel(name: String? = "Nome do usuário completo",
                             email: String? = "emailusuari@dominio.com", password: String? = "secret", passwordConfirmation: String? = "secret") -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    func makeAlertViewModelIfRequiredField(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(field) é obrigatório")
    }
    
    func makeErrorAlertViewModel(title: String, message: String) -> AlertViewModel {
        return AlertViewModel(title: title, message: message)
    }
    func makeInvalidAlertViewModel(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(field) é Inválido")
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
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void ) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
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
    class  LoadingViewSpy: LoadingView {
        var viewModel: LoadingViewModel?
        func display(viewModel: LoadingViewModel) {
            self.viewModel = viewModel
        }
    }
}
