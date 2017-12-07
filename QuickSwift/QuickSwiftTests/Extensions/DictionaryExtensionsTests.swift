//
//  DictionaryExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest

class DictionaryExtensionsTests: XCTestCase {

    let dictionary = [1:"1", 2:"2"]

    func testHasKey() {
        XCTAssertEqual(dictionary.has(key: 1), true)
        XCTAssertEqual(dictionary.has(key: 0), false)
    }

    func testHasValue() {
        XCTAssertEqual(dictionary.has(value: "1"), true)
        XCTAssertEqual(dictionary.has(value: "0"), false)
    }

    func testFliped() {
        XCTAssertEqual(dictionary.fliped(), ["1":1, "2":2])
    }

}
