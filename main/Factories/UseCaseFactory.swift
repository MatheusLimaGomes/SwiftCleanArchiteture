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
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseUrl)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        let remoteAddAccount = RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
        return DispatchMainQueueDecorator(remoteAddAccount)
    }
}
