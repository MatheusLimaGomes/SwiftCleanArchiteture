//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Matheus Lima Gomes on 23/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

public final  class RemoteAddAccount: AddAccount {
    private var url: URL
    private var httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url =  url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel,  DomainError>) ->  Void )  {
        httpClient.post(to: url, with: addAccountModel.toData() ) { [ weak self ]result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: AccountModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
        
    }
}
