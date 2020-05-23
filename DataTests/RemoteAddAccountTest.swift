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
    private var httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient ) {
        self.url =  url
        self.httpClient = httpClient
    }
    func add()  {
        httpClient.post(url: url)
    }
}
protocol HttpPostClient {
    func post(url: URL)
}
class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () throws {
        let url =  URL(string: "http://teste.dominio.com.br")!
        let httpClientSpy = HTTTPClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

extension RemoteAddAccountTest {
    class HTTTPClientSpy: HttpPostClient {
        var url: URL?
        func post(url: URL) {
            self.url = url
        }
    }
}
