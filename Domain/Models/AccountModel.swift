//
//  AccountModel.swift
//  Domain
//
//  Created by Matheus Lima Gomes on 14/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public struct AccountModel: Model {
   public var id: String
   public var name: String
   public var email: String
   public var password: String
    
    public init(id: String, name: String, email: String,
                password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
