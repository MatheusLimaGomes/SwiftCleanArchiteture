//
//  RemoteAddAccountTest.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 20/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest

class RemoteAddAccount {
    private var url: URL
    private var httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient ) {
        self.url =  url
        self.httpClient = httpClient
    }
    func add()  {
        httpClient.post(url: url)
    }
}
protocol HttpClient {
    func post(url: URL)
}
class HTTTPClientSpy: HttpClient {
    var url: URL?
    func post(url: URL) {
        self.url = url
    }
}
class RemoteAddAccountTest: XCTestCase {
    func test_ () throws {
        let url =  URL(string: "http://teste.dominio.com.br")!
        let httpClientSpy = HTTTPClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}
