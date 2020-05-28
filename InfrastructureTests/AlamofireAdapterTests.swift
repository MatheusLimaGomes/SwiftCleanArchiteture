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
}
extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: config)
        return AlamofireAdapter(session: session)
    }
    
    func makeRequestFor(to url: URL = makeURL(),
                        with data: Data?,
                        action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        sut.post(to: url, with: data)
        let exp = expectation(description: "wating")
        URLProtocolStub.observeRequest { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
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
