//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "any_id", name: "Nome do usuário completo", email: "emailusuari@dominio.com", password: "secret")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "Nome do usuário completo", email: "emailusuari@dominio.com", password: "secret", passwordConfirmation: "secret")
}
