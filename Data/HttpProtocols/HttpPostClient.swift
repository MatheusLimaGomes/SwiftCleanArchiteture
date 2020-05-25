//
//  HttpPostClient.swift
//  Data
//
//  Created by Matheus Lima Gomes on 23/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation


public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpClientError>) -> Void)
}
