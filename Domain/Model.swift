//
//  Model.swift
//  Domain
//
//  Created by Matheus Lima Gomes on 23/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public protocol Model: Encodable {}


public extension Model {
    func toData() -> Data?  {
        return try? JSONEncoder().encode(self)
    }
    
}
