//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Matheus Lima Gomes on 23/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

public final  class RemoteAddAccount {
    private var url: URL
    private var httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient ) {
        self.url =  url
        self.httpClient = httpClient
    }
    public func add(addAccountModel: AddAccountModel)  {
        httpClient.post(to: url, with: addAccountModel.toData() )
    }
}
