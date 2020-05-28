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

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpClientError>)  ->  Void) {
        session.request(url, method: .post, parameters: data?
            .toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
                switch dataResponse.result {
                case .failure: completion(.failure(.noConnectivity))
                case .success: break
                }
        }
    }
}
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
    
    func test_post_should_complete_with_error_when_requestcompletes_with_error() {
        let sut = makeSut()
        URLProtocolStub.setup(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "wating")
        sut.post(to: makeURL(), with: makeValidData()) { result in
            switch  result  {
            case   .failure(let error):
                XCTAssertEqual(error, .noConnectivity)
            case .success(_): XCTFail("Expected Error got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
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
}
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
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    override open func stopLoading() {}
}
