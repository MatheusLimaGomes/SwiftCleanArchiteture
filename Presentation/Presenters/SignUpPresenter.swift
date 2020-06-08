//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 06/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation


public struct SignUpViewModel {
   public var name: String?
   public var email: String?
   public var password: String?
   public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil,
                password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}

public final class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator?
    
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    public func signUp(_ viewModel: SignUpViewModel) {
        if let message = validateViewModel(viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
    
    private func validateViewModel(_ viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return  "O campo nome é obrigatório"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo email é obrigatório"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo password é obrigatório"
        }  else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "O campo Confirmar Senha é obrigatório"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "As senhas não coincidem"
        }
        _ = emailValidator?.isValid(email: viewModel.email!)
        return nil
    }
}
