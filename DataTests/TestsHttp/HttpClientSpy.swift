//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Data

class HTTTPClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpClientError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpClientError>) -> Void) {
        self.urls .append(url)
        self.data = data
        self.completion = completion
    }
    func completeWithError(_ error: HttpClientError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data)  {
        completion?(.success(data))
    }
}
