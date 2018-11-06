//
//  DictionaryExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class DictionaryExtensionsTests: XCTestCase {

    var shortDictionary = [1: "1", 10: "10"]
    var dictionary = [1: "1", 2: "2", 3: "1", 4: "1", 5: "2"]

    func testHasKey() {
        XCTAssertEqual(dictionary.has(key: 1), true)
        XCTAssertEqual(dictionary.has(key: 0), false)
    }

    func testRemoveAllKeys() {
        dictionary.removeAll(keys: [1, 2])
        XCTAssertEqual(dictionary, [3: "1", 4: "1", 5: "2"])
    }

    func testRemove() {
        dictionary.removeValue(forKey: 1)
        XCTAssertEqual(dictionary, [2: "2", 3: "1", 4: "1", 5: "2"])
        dictionary.removeValue(forValue: "1")
        XCTAssertEqual(dictionary, [2: "2", 5: "2"])
        dictionary.removeValue(forValue: "2")
        XCTAssertEqual(dictionary, [:])
    }

    func testRemoveAllValuesSingle() {
        dictionary.removeAll(values: ["1"])
        XCTAssertEqual(dictionary, [2: "2", 5: "2"])
    }

    func testRemoveAllValues() {
        dictionary.removeAll(values: ["1", "2"])
        XCTAssertEqual(dictionary, [:])
    }

    func testHasValue() {
        XCTAssertEqual(dictionary.has(value: "1"), true)
        XCTAssertEqual(dictionary.has(value: "0"), false)
    }

    func testFliped() {
        XCTAssertEqual(shortDictionary.fliped(), ["1": 1, "10": 10])
    }

    func testOperatorPlus() {
        XCTAssertEqual(dictionary + shortDictionary, [1: "1", 2: "2", 3: "1", 4: "1", 5: "2", 10: "10"])
        dictionary += shortDictionary
        XCTAssertEqual(dictionary, [1: "1", 2: "2", 3: "1", 4: "1", 5: "2", 10: "10"])
    }

    func testOperatorMinus() {
        XCTAssertEqual(dictionary - shortDictionary, [2: "2", 3: "1", 4: "1", 5: "2"])
        dictionary -= shortDictionary
        XCTAssertEqual(dictionary, [2: "2", 3: "1", 4: "1", 5: "2"])
    }

}
