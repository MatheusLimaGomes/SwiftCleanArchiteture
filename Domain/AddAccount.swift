//
//  AddAccount.swift
//  Domain
//
//  Created by Matheus Lima Gomes on 14/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel:  AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmatio:String
}
