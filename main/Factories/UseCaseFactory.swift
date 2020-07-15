//
//  UseCaseFactory.swift
//  main
//
//  Created by Matheus Lima Gomes on 15/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Infrastructure
import Domain
import Data

final class UseCaseFactory {
    static func makeRemoteAddAccount() -> AddAccount {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    }
}
