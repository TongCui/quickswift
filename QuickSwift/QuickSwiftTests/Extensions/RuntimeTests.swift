//
//  RuntimeTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest


class RuntimeTests: XCTestCase {
    
    func testExtensionStoreProperty() {
        
        let demo = AssociatedObjectDemo()
        XCTAssertEqual(demo.name, "name")
        XCTAssertEqual(demo.age, 0)
        demo.age = 10
        XCTAssertEqual(demo.age, 10)
    }
}
