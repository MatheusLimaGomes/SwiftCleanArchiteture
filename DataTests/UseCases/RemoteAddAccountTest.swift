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
        let url = self.makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in}
        XCTAssertEqual(httpClientSpy.urls, [url] )
    }
    
    func test_add_should_call_httpClient_with_correct_data () throws {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in}
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_error () throws {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completesWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivityError)
        }
    }
    
    func test_add_should_complete_with_data_if_client_complete_with_valid_data () throws {
      let (sut, httpClientSpy) = makeSut()
        let expectedAccount = makeAccountModel()
        expect(sut, completesWith: .success(expectedAccount)) {
            httpClientSpy.completeWithData(expectedAccount.toData()!)
        }
    }
    
    
    func test_add_should_complete_with_error_if_client_complete_with_invalid_data () throws {
      let (sut, httpClientSpy) = makeSut()
      expect(sut, completesWith: .failure(.unexpected)) {
             httpClientSpy.completeWithData(makeInvalidData())
        }
    }
}

extension RemoteAddAccountTest {
    
    func makeSut(url: URL = URL(string: "http://teste.dominio.com.br")!) -> (sut: RemoteAddAccount, httpClient: HTTTPClientSpy ) {
        let httpClientSpy = HTTTPClientSpy()
         let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    func expect(_ sut: RemoteAddAccount, completesWith expectedResult: (Result<AccountModel, DomainError>), when action: () -> Void) {
        let exp = expectation(description: "wating")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    func makeURL() -> URL {
        return URL(string: "http://teste.dominio.com.br")!

    }
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Nome do usuário completo", email: "emailusuari@dominio.com", password: "3456178", passwordConfirmation: "3456178")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id", name: "Nome do usuário completo", email: "emailusuari@dominio.com", password: "3456178")
    }
    func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
    }
    class HTTTPClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpClientError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpClientError>) -> Void) {
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
}
