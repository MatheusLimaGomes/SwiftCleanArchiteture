//
//  Data+Extensions.swift
//  Data
//
//  Created by Matheus Lima Gomes on 25/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}
