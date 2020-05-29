//
//  URLProtocolStub.swift
//  InfrastructureTests
//
//  Created by Matheus Lima Gomes on 29/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func setup(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response  = response
        self.error = error
    }
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override open func startLoading() {
        URLProtocolStub.emit?(request)
        if let data =  URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response,
                                cacheStoragePolicy: .notAllowed)
        }
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    override open func stopLoading() {}
}
