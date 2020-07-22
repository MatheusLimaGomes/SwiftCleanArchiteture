//
//  DispatchMainQueueDecorator.swift
//  main
//
//  Created by Matheus Lima Gomes on 22/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain 

public final class DispatchMainQueueDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    func dispath(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion)}
        completion()
    }
}

extension DispatchMainQueueDecorator: AddAccount where T: AddAccount {
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispath { completion(result) }
        }
    }
    
}
