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
    
    func test_signUp_should_call_addAccount_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "wating")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro!", message: "Algo inesperado aconteceu, tente novamente em alguns instantes.") )
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel())
        addAccountSpy.completesWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    func test_signUp_should_show_error_message_if_addAccount_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "wating")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta Criada Com Sucesso.") )
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel())
        addAccountSpy.completesWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    func test_signUp_should_show_loading_before_and_after_call_of_addAccount () throws {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isActive: true))
            exp.fulfill()
        }
        sut.signUp(makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isActive: false))
            exp2.fulfill()
        }
        addAccountSpy.completesWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    func test_signUp_should_call_validation_with_corect_values() throws {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to:viewModel.toJson()!))
    }
    func test_signUp_should_show_error_message_if_validation_fails () throws {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "watiing")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel,
                           AlertViewModel(title: "Falha na validação",
                                          message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }

}

extension SignupPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) ->  SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line )
        return sut
    }
}
