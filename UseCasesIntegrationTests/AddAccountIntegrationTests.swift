//
//  AddAccountIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Matheus Lima Gomes on 31/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import XCTest
import Data
import Infrastructure
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel: AddAccountModel = AddAccountModel(name: "Matheus Francisco", email: "matheus.francisco.gomes@domain.com", password: "secret", passwordConfirmation: "secret")
        let exp = expectation(description: "wating")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expected Success, got \(result) isntead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(addAccountModel.name, account.name)
                XCTAssertEqual(addAccountModel.email, account.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
