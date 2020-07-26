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
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView, addAccount: AddAccount, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    public func signUp(_ viewModel: SignUpViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isActive: true))
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel)) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isActive: false))
                switch result {
                case .failure:
                    self.alertView
                        .showMessage(viewModel: AlertViewModel(title: "Erro!",
                                                               message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso",
                                                                         message: "Conta Criada Com Sucesso."))
                }
            }
        }
    }
}
