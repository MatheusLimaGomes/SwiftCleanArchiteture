//
//  Extensions+TestHelper.swift
//  DataTests
//
//  Created by Matheus Lima Gomes on 27/05/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [ weak instance ] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
