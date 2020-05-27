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
        expect(sut, completesWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivityError)
        })
    }
    
    func test_add_should_complete_with_data_if_client_complete_with_valid_data () throws {
      let (sut, httpClientSpy) = makeSut()
        let expectedAccount = makeAccountModel()
        expect(sut, completesWith: .success(expectedAccount), when: {
            httpClientSpy.completeWithData(expectedAccount.toData()!)
        })
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_invalid_data () throws {
      let (sut, httpClientSpy) = makeSut()
      expect(sut, completesWith: .failure(.unexpected), when: {
             httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    func test_add_should_not_complete_if_sut_has_been_deallocated () throws {
        let httpClient = HTTTPClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeURL(), httpClient: httpClient)
        var result: Result<AccountModel, DomainError>?
        sut?.add(addAccountModel: makeAddAccountModel ()) { result = $0 }
        sut = nil
        httpClient.completeWithError(.noConnectivityError)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTest {
    
    func makeSut(url: URL = URL(string: "http://teste.dominio.com.br")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAddAccount, httpClient: HTTTPClientSpy) {
        let httpClientSpy = HTTTPClientSpy()
         let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, httpClientSpy)
    }
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [ weak instance ] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func expect(_ sut: RemoteAddAccount, completesWith expectedResult: (Result<AccountModel, DomainError>), when action: () -> Void,  file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "wating")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
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
