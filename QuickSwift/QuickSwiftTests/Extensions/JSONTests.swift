//
//  JSONTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
import UIKit
@testable import QuickSwift

class JSONTests: XCTestCase {

    let intArray = [1, 2, 3]
    let stringArray = ["1", "2", "3"]
    let intKeyDictionary = [1:"100", 2:"200"]
    let stringKeyDictionary = ["1":"100", "2":"200"]
    let complexArray: [Any] = [1, "string", [1, 2], ["k":"v"]]
    let complexDictionary: [String: Any] = ["1":["k":"v"], "2":[1, 2, 3], "3":1, "4":"name"]

    func testValid() {
        XCTAssertTrue(JSON.isValid(any: intArray))
        XCTAssertTrue(JSON.isValid(any: stringArray))
        XCTAssertTrue(JSON.isValid(any: stringKeyDictionary))
        XCTAssertTrue(JSON.isValid(any: complexArray))
        XCTAssertTrue(JSON.isValid(any: complexDictionary))

        XCTAssertFalse(JSON.isValid(any: Data()))
        XCTAssertFalse(JSON.isValid(any: Date()))
        XCTAssertFalse(JSON.isValid(any: NSNull()))
        XCTAssertFalse(JSON.isValid(any: UILabel()))
        XCTAssertFalse(JSON.isValid(any: ""))
        XCTAssertFalse(JSON.isValid(any: 1))
        XCTAssertFalse(JSON.isValid(any: "1"))

        XCTAssertFalse(JSON.isValid(any: intKeyDictionary))
    }

    func testParse() {

        XCTAssertEqual(try JSON.parse(fromString: "[1,2,3]"), intArray)
        XCTAssertEqual(try JSON.parse(fromString: "[\"1\",\"2\",\"3\"]"), stringArray)
        XCTAssertEqual(try JSON.parse(fromString: "{\"1\":\"100\",\"2\":\"200\"}"), stringKeyDictionary)
        let resComplexArray: [Any]? = try? JSON.parse(fromString: "[1,\"string\",[1,2],{\"k\":\"v\"}]")
        XCTAssertNotNil(resComplexArray)
        XCTAssertTrue(resComplexArray!.count > 1)
        let resComplexDictionary: [String: Any]? = try? JSON.parse(fromString: "{\"1\":{\"k\":\"v\"},\"2\":[1,2,3],\"3\":1,\"4\":\"name\"}")
        XCTAssertNotNil(resComplexDictionary)
        XCTAssertTrue(resComplexDictionary!.count > 1)

        XCTAssertThrowsError(try JSON.parse(fromString: "abc") as [String])
        XCTAssertThrowsError(try JSON.parse(fromString: "") as [String])

        // Wrong Type
        let resStringArray: [String]? = try? JSON.parse(fromString: "[1,2,3]")
        XCTAssertNil(resStringArray)

        let resIntArray: [Int]? = try? JSON.parse(fromString: "[\"1\",\"2\",\"3\"]")
        XCTAssertNil(resIntArray)

        let resIntKeyDictionary: [Int: Any]? = try? JSON.parse(fromString: "{\"1\":{\"k\":\"v\"},\"2\":[1,2,3],\"3\":1,\"4\":\"name\"}")
        XCTAssertNil(resIntKeyDictionary)

        let resIntComplexArray: [Int]? = try? JSON.parse(fromString: "[1,\"string\",[1,2],{\"k\":\"v\"}]")
        XCTAssertNil(resIntComplexArray)
    }

    func testDump() {
        XCTAssertEqual(try JSON.dump(toString: intArray), "[1,2,3]")
        XCTAssertEqual(try JSON.dump(toString: stringArray), "[\"1\",\"2\",\"3\"]")
        XCTAssertEqual(try JSON.dump(toString: stringArray, prettify: true), "[\n  \"1\",\n  \"2\",\n  \"3\"\n]")
        XCTAssertThrowsError(try JSON.dump(toString: intKeyDictionary))
        XCTAssertThrowsError(try JSON.dump(toString: "1"))
        XCTAssertEqual(try JSON.dump(toString: stringKeyDictionary), "{\"1\":\"100\",\"2\":\"200\"}")
        XCTAssertEqual(try JSON.dump(toString: complexArray), "[1,\"string\",[1,2],{\"k\":\"v\"}]")
        XCTAssertEqual(try JSON.dump(toString: complexDictionary), "{\"1\":{\"k\":\"v\"},\"2\":[1,2,3],\"3\":1,\"4\":\"name\"}")
    }

    func testJSONError() {
        do {
            _ = try JSON.dump(toString: "1")
        } catch {
            if let error = error as? JSONError {
                XCTAssertEqual("Failed: invalid json object", error.toS())
            }
        }

        do {
            let wrongType: [String] = try JSON.parse(fromString: "[1,2,3]")
            print("\(wrongType)")
        } catch {
            if let error = error as? JSONError {
                XCTAssertEqual("Failed: invalid type Array<String>", error.toS())
            }
        }
    }
}
