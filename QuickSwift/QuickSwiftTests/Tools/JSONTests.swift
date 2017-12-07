//
//  JSONTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class JSONTests: XCTestCase {

    let intArray = [1, 2, 3]
    let stringArray = ["1", "2", "3"]
    let intKeyDictionary = [1:"100", 2:"200"]
    let stringKeyDictionary = ["1":"100", "2":"200"]

    func testJSONStringConvertibleProtocol() {
        XCTAssertEqual(self.intArray.toJSON, "[1,2,3]" )
        XCTAssertEqual(stringArray.toJSON, "[\"1\",\"2\",\"3\"]" )
        XCTAssertEqual(intKeyDictionary.toJSON, nil )
        XCTAssertEqual(stringKeyDictionary.toJSON, "{\"1\":\"100\",\"2\":\"200\"}" )

        XCTAssertEqual(Array(jsonString: "[1,2,3]")!, [1, 2, 3])
        XCTAssertEqual(Array(jsonString: "[1,2,3]")!, [1.0, 2.0, 3.0])
        XCTAssertEqual(Dictionary(jsonString: "{\"1\":\"100\",\"2\":\"200\"}")!, ["1":"100", "2":"200"])
        let intDictionary: [Int: String]? = Dictionary(jsonString: "{1:\"100\",2:\"200\"}")
        XCTAssertNil(intDictionary)
        let stringDictionary: [String: String]? = Dictionary(jsonString: "{1:\"100\",2:\"200\"}")
        XCTAssertNil(stringDictionary)

        let intArray: [Int]? = Array(jsonString: "[1,2,3]")
        XCTAssertNotNil(intArray)
        XCTAssertEqual(intArray!, [1, 2, 3])

        let intStringDictionary: [Int: String]? = Dictionary(jsonString: "{\"1\":\"100\",\"2\":\"200\"}")
        XCTAssertNil(intStringDictionary)

        let stringStringDictionary: [String: String]? = Dictionary(jsonString: "{\"1\":\"100\",\"2\":\"200\"}")
        XCTAssertEqual(stringStringDictionary!, ["1":"100", "2":"200"])
    }

    func testJSONStringPretty() {
        XCTAssertEqual(stringKeyDictionary.jsonString(prettify: false), "{\"1\":\"100\",\"2\":\"200\"}" )
        XCTAssertEqual(stringKeyDictionary.jsonString(prettify: true), "{\n  \"2\" : \"200\",\n  \"1\" : \"100\"\n}" )
    }

    func testJSONParseArray() {
        var string = "[1,2,3]"
        var resIntArray: [Int]?
        var resStringArray: [String]?
        resIntArray = JSON.parseArray(fromData: string.data(using: .utf8)!)
        XCTAssertEqual(resIntArray!, [1, 2, 3])

        resIntArray = JSON.parseArray(fromString: string)
        XCTAssertEqual(resIntArray!, [1, 2, 3])

        string = "[\"1\",\"2\",\"3\"]"
        resStringArray = JSON.parseArray(fromData: string.data(using: .utf8)!)
        XCTAssertEqual(resStringArray!, ["1", "2", "3"])

        resStringArray = JSON.parseArray(fromString: string)
        XCTAssertEqual(resStringArray!, ["1", "2", "3"])

        string = "abcd"
        resStringArray = JSON.parseArray(fromData: string.data(using: .utf8)!)
        XCTAssertNil(resStringArray)

        resStringArray = JSON.parseArray(fromString: string)
        XCTAssertNil(resStringArray)

        resIntArray = JSON.parseArray(fromData: Data())
        XCTAssertNil(resIntArray)
        resIntArray = JSON.parseArray(fromString: "")
        XCTAssertNil(resIntArray)
    }

    func testJSONParseDictionary() {
        var string = "{\"1\":\"100\",\"2\":\"200\"}"
        var resIntDictionary: [String: Int]?
        var resStringDictionary: [String: String]?

        resIntDictionary = JSON.parseDictionary(fromString: string)
        XCTAssertNil(resIntDictionary)

        resIntDictionary = JSON.parseDictionary(fromData: string.data(using: .utf8)!)
        XCTAssertNil(resIntDictionary)

        resStringDictionary = JSON.parseDictionary(fromString: string)
        XCTAssertEqual(resStringDictionary!, ["1":"100", "2":"200"])

        resStringDictionary = JSON.parseDictionary(fromData: string.data(using: .utf8)!)
        XCTAssertEqual(resStringDictionary!, ["1":"100", "2":"200"])

        string = "abcd"
        resStringDictionary = JSON.parseDictionary(fromData: string.data(using: .utf8)!)
        XCTAssertNil(resStringDictionary)

        resStringDictionary = JSON.parseDictionary(fromString: string)
        XCTAssertNil(resStringDictionary)

        resStringDictionary = JSON.parseDictionary(fromData: Data())
        XCTAssertNil(resStringDictionary)
        resStringDictionary = JSON.parseDictionary(fromString: "")
        XCTAssertNil(resStringDictionary)
    }

    func testJSONDump() {
        XCTAssertEqual(JSON.dump(any: intArray), "[1,2,3]" )
        XCTAssertEqual(JSON.dump(any: stringArray), "[\"1\",\"2\",\"3\"]" )
        XCTAssertEqual(JSON.dump(any: intKeyDictionary), nil )
        XCTAssertEqual(JSON.dump(any: stringKeyDictionary), "{\"1\":\"100\",\"2\":\"200\"}" )

    }
}
