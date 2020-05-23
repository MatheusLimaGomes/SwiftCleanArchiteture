//
//  RemoteAddAccountTest.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 20/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Domain

class RemoteAddAccount {
    private var url: URL
    private var httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient ) {
        self.url =  url
        self.httpClient = httpClient
    }
    func add(addAccountModel: AddAccountModel)  {
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data )
    }
}
protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
class RemoteAddAccountTest: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url () throws {
        let url =  URL(string: "http://teste.dominio.com.br")!
        let httpClientSpy = HTTTPClientSpy()
        let addAccountModel = AddAccountModel(name: "", email: "", password: "", passwordConfirmation: "")
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data () throws {
        let httpClientSpy = HTTTPClientSpy()
        let addAccountModel = AddAccountModel(name: "", email: "", password: "", passwordConfirmation: "")
        let sut = RemoteAddAccount(url: URL(string: "http://teste.dominio.com.br")!,
                                   httpClient: httpClientSpy)
        sut.add(addAccountModel: addAccountModel)
        let data = try? JSONEncoder().encode(addAccountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

extension RemoteAddAccountTest {
    class HTTTPClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post (to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
