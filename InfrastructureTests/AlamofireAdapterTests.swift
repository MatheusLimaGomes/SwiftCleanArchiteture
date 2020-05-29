//
//  AlamofireAdapterTestes .swift
//  InfrastructureTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Alamofire
import Data
import Infrastructure

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeURL()
        makeRequestFor(to: url, with: makeValidData()) {
            XCTAssertEqual(url, $0.url)
            XCTAssertEqual("POST", $0.httpMethod)
            XCTAssertNotNil($0.httpBodyStream)
        }
    }
    func test_post_should_make_request_with_no_data() throws {
        makeRequestFor(with: makeInvalidData()) {
            XCTAssertNil($0.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error_on_valid_cases() {
        expectResult(.failure(.noConnectivity),
                     when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_200_on_valid_cases() {
        expectResult(.success(makeValidData()),
                     when: (data: makeValidData(),
                            response: makeHTTPURLesponse(), error: nil))
    }
    
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_204_on_valid_cases() {
        expectResult(.success(nil), when: (data: nil,
                                           response: makeHTTPURLesponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(),
                                           response: makeHTTPURLesponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(),
                                           response: makeHTTPURLesponse(statusCode: 204), error: nil))

    }
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_400_on_valid_cases() {
        expectResult(.failure(.badRequest),
                     when: (data: makeValidData(), response: makeHTTPURLesponse(statusCode: 400), error: nil))
    }
    
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_401_on_valid_cases() {
        expectResult(.failure(.unauthorized),
                     when: (data: makeValidData(), response: makeHTTPURLesponse(statusCode: 401), error: nil))
    }
    
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_403_on_valid_cases() {
        expectResult(.failure(.forbidden),
                     when: (data: makeValidData(), response: makeHTTPURLesponse(statusCode: 403), error: nil))
    }
    func test_post_should_complete_with_success_when_request_completes_with_statuscode_500_on_valid_cases() {
        expectResult(.failure(.serverError),
                     when: (data: makeValidData(), response: makeHTTPURLesponse(statusCode: 500), error: nil))
    }
    
    func test_post_should_complete_with_error_on_invalid_cases() {
        expectResult(.failure(.noConnectivity),
                     when: (data: makeValidData(), response: makeHTTPURLesponse(statusCode: 200), error: makeError()))
        expectResult(.failure(.noConnectivity),
                     when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivity),
                     when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity),
                     when: (data: nil, response: makeHTTPURLesponse(), error: makeError()))
        expectResult(.failure(.noConnectivity),
                     when: (data: nil, response: makeHTTPURLesponse(), error: nil))
        expectResult(.failure(.noConnectivity),
                     when: (data: nil, response: nil, error: nil))
    }
}
extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: config)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func makeRequestFor(to url: URL = makeURL(),
                        with data: Data?,
                        action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "wating")
        sut.post(to: url, with: data) { _ in exp.fulfill() }
        var request: URLRequest?
        URLProtocolStub.observeRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpClientError>,
                      when stub: (data: Data?, response: HTTPURLResponse?, error: Error?),
                      file: StaticString = #file, line: UInt = #line ) {
        
        let sut = makeSut()
        URLProtocolStub.setup(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "wating")
        sut.post(to: makeURL(), with: makeValidData()) { receivedResult in
            switch  (expectedResult, receivedResult)  {
            case  (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) got \(receivedResult) instead",
                file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
