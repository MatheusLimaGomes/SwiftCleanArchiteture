//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 06/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain


public final class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    public func signUp(_ viewModel: SignUpViewModel) {
        if let message = validateViewModel(viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isActive: true))
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure:
                    self.alertView
                        .showMessage(viewModel: AlertViewModel(title: "Erro!",
                                                               message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso",
                                                                         message: "Conta Criada Com Sucesso."))
                }
                self.loadingView.display(viewModel: LoadingViewModel(isActive: false))
            }
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
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "O campo Email é Inválido"
        }
        return nil
    }
}