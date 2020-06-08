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
        let (sut, alertViewSpy, _) = makeSut()
        
        let signUpViewModel = SignUpViewModel(email: "email@email.com", password: "secret", passwordConfirmation: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided () throws {
        let (sut, alertViewSpy, _) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any name", password: "secret", passwordConfirmation: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided () throws {
        let (sut, alertViewSpy, _) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any name", email: "any-email@domain.com", passwordConfirmation: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo password é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided () throws {
        let (sut, alertViewSpy, _) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any name", email: "any-email@domain.com", password: "secret")
        sut.signUp(signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatório"))
    }
    
      func test_signUp_should_show_error_message_if_passwordConfirmation_not_match () throws {
          let (sut, alertViewSpy, _) = makeSut()
          
          let signUpViewModel = SignUpViewModel(name: "any name", email: "any-email@domain.com", password: "secret", passwordConfirmation: "wrong-passord")
          sut.signUp(signUpViewModel)
          XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "As senhas não coincidem"))
      }
      
        func test_signUp_should_call_email_validator_with_correct_email () throws {
            let (sut, _, emailValidatorSpy) = makeSut()
            
            let signUpViewModel = SignUpViewModel(name: "any name", email: "any-email@domain.com", password: "secret", passwordConfirmation: "secret")
            sut.signUp(signUpViewModel)
            XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email )
        }
}
 
extension SignupPresenterTests {
    func makeSut() -> (sut: SignUpPresenter, alertViewspy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy) {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (sut, alertViewSpy, emailValidatorSpy)
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
