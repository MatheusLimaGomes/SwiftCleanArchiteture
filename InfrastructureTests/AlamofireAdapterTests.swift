//
//  AlamofireAdapterTestes .swift
//  InfrastructureTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    func post(to url: URL, with data: Data?) {
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}
class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() throws {
        let url = makeURL()
        let sut = makeSut()
        sut.post(to: url, with: makeValidData())
        let exp = expectation(description: "wating")
        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    func test_post_should_make_request_with_no_data() throws {
        let url = makeURL()
        let sut = makeSut()
        sut.post(to: url, with: nil)
        let exp = expectation(description: "wating")
        URLProtocolStub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: config)
        return AlamofireAdapter(session: session)
    }
}
class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
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
    }
    override open func stopLoading() {}

}
