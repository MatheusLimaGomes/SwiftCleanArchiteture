//
//  GenericHelpers.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation


func makeURL() -> URL {
    return URL(string: "http://teste.dominio.com.br")!
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}
func makeValidData() -> Data {
    return Data("{\"name\": \"any_name\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_domain", code:  0 )
}
