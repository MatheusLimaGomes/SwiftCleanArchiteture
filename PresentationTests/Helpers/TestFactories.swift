//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

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

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
       return AlertViewModel(title: "Sucesso", message: message)
}

func makeInvalidAlertViewModel(field: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(field) é Inválido")
}
