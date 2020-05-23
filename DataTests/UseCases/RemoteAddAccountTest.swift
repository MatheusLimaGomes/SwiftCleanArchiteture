//
//  RemoteAddAccountTest.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 20/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTest: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url () throws {
        let url =  URL(string: "http://teste.dominio.com.br")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.urls, [url] )
    }
    
    func test_add_should_call_httpClient_with_correct_data () throws {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTest {
    
    func makeSut(url: URL = URL(string: "http://teste.dominio.com.br")!) -> (sut: RemoteAddAccount, httpClient: HTTTPClientSpy ) {
        let httpClientSpy = HTTTPClientSpy()
         let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Nome do usuário completo", email: "emailusuari@dominio.com", password: "3456178", passwordConfirmation: "3456178")
    }
    class HTTTPClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        
        
        func post (to url: URL, with data: Data?) {
            self.urls .append(url)
            self.data = data
        }
    }
}
