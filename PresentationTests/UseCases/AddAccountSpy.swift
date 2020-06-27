//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

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
    func completesWithAccount(_ account: AccountModel) {
        self.completion?(.success(account))
    }
}
