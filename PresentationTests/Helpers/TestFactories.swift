//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "Nome do usuário completo",
                         email: String? = "emailusuari@dominio.com", password: String? = "secret", passwordConfirmation: String? = "secret") -> SignUpViewModel {
    return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
