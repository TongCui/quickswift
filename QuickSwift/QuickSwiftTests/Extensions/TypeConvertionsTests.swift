//
//  TypeConvertionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class TypeConvertionsTests: XCTestCase {

    func testConvertFromBool() {
        var input = true
        XCTAssertEqual(input.toI(), 1)
        XCTAssertEqual(input.toF(), 1.0)
        XCTAssertEqual(input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "true")

        input = false
        XCTAssertEqual(input.toI(), 0)
        XCTAssertEqual(input.toF(), 0)
        XCTAssertEqual(input.toD(), 0)
        XCTAssertEqual(input.toS(), "false")
    }

    func testConvertFromInt() {
        var input: Int = 1
        XCTAssertEqual(input.toF(), 1.0)
        XCTAssertEqual(input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "1")
        XCTAssertTrue(input.toB())

        input = 0
        XCTAssertEqual(input.toF(), 0)
        XCTAssertEqual(input.toD(), 0)
        XCTAssertEqual(input.toS(), "0")
        XCTAssertFalse(input.toB())

        input = -1
        XCTAssertEqual(input.toF(), -1)
        XCTAssertEqual(input.toD(), -1)
        XCTAssertEqual(input.toS(), "-1")
        XCTAssertFalse(input.toB())

        input = 97
        XCTAssertEqual(try input.toChr(), "a")
        input = 65
        XCTAssertEqual(try input.toChr(), "A")
        input = 0
        XCTAssertThrowsError(try input.toChr())
        input = -1
        XCTAssertThrowsError(try input.toChr())
        input = 100000
        XCTAssertThrowsError(try input.toChr())

        do {
            _ = try (-1).toChr()
        } catch {
            if let error = error as? TypeConvertError<Int, Character> {
                XCTAssertEqual(error.description, "Failed: Cannot convert from Int to Character")
            }
        }
    }

    func testConvertFromFloat() {
        var input: Float = 1.0
        XCTAssertEqual(input.toI(), 1)
        XCTAssertEqual(input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "1.0")

        input = 0
        XCTAssertEqual(input.toI(), 0)
        XCTAssertEqual(input.toD(), 0)
        XCTAssertEqual(input.toS(), "0.0")

        input = -1
        XCTAssertEqual(input.toI(), -1)
        XCTAssertEqual(input.toD(), -1)
        XCTAssertEqual(input.toS(), "-1.0")
    }

    func testConvertFromDouble() {
        var input: Double = 1.0
        XCTAssertEqual(input.toI(), 1)
        XCTAssertEqual(input.toF(), 1.0)
        XCTAssertEqual(input.toS(), "1.0")

        input = 0
        XCTAssertEqual(input.toI(), 0)
        XCTAssertEqual(input.toF(), 0)
        XCTAssertEqual(input.toS(), "0.0")

        input = -1
        XCTAssertEqual(input.toI(), -1)
        XCTAssertEqual(input.toF(), -1)
        XCTAssertEqual(input.toS(), "-1.0")
    }

    func testConvertFromString() {
        var input: String = "1"
        XCTAssertEqual(try input.toI(), 1)
        XCTAssertEqual(try input.toF(), 1.0)
        XCTAssertEqual(try input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "1")

        input = "+1"
        XCTAssertEqual(try input.toI(), 1)
        XCTAssertEqual(try input.toF(), 1.0)
        XCTAssertEqual(try input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "+1")

        input = "1.0"
        XCTAssertThrowsError(try input.toI())
        XCTAssertEqual(try input.toF(), 1.0)
        XCTAssertEqual(try input.toD(), 1.0)
        XCTAssertEqual(input.toS(), "1.0")

        input = "0"
        XCTAssertEqual(try input.toI(), 0)
        XCTAssertEqual(try input.toF(), 0)
        XCTAssertEqual(try input.toD(), 0)
        XCTAssertEqual(input.toS(), "0")

        input = "-0"
        XCTAssertEqual(try input.toI(), 0)
        XCTAssertEqual(try input.toF(), 0)
        XCTAssertEqual(try input.toD(), 0)
        XCTAssertEqual(input.toS(), "-0")

        input = "-1"
        XCTAssertEqual(try input.toI(), -1)
        XCTAssertEqual(try input.toF(), -1)
        XCTAssertEqual(try input.toD(), -1)
        XCTAssertEqual(input.toS(), "-1")

        input = "abc"
        XCTAssertThrowsError(try input.toI())
        XCTAssertThrowsError(try input.toF())
        XCTAssertThrowsError(try input.toD())
        XCTAssertEqual(input.toS(), "abc")

        input = "[1, 2, 3]"
        XCTAssertEqual([1, 2, 3], try input.toJSONObject())
        XCTAssertEqual([1, 2, 3], try input.toArray())

        input = "[\"1\", \"2\", \"3\"]"
        XCTAssertEqual(["1", "2", "3"], try input.toJSONObject())
        XCTAssertEqual(["1", "2", "3"], try input.toArray())

        input = "{\"1\":\"100\",\"2\":\"200\"}"
        XCTAssertEqual(["1":"100", "2":"200"], try input.toJSONObject())
        XCTAssertEqual(["1":"100", "2":"200"], try input.toDictionary())

        //  Error
        input = "[1, \"2\", \"3\"]"
        XCTAssertThrowsError(try input.toJSONObject() as [String])
        XCTAssertThrowsError(try input.toArray() as [String])

        input = "{1:\"100\",\"2\":\"200\"}"
        XCTAssertThrowsError(try input.toJSONObject() as [String: Any])
        XCTAssertThrowsError(try input.toDictionary() as [String: Int])
    }

    func testConvertData() {
        var input = "abc"

        XCTAssertEqual(input.toUtf8Data().count, 3)
        XCTAssertEqual(try input.toUtf8Data().toUtf8S(), "abc")

        input = "Não, l'été c'est pour bientôt"
        XCTAssertTrue(input.toUtf8Data().count > 10)

        input = "[1, 2, 3]"
        XCTAssertEqual([1, 2, 3], try input.toUtf8Data().toJSONObject())
        XCTAssertEqual([1, 2, 3], try input.toUtf8Data().toArray())

        input = "[\"1\", \"2\", \"3\"]"
        XCTAssertEqual(["1", "2", "3"], try input.toUtf8Data().toJSONObject())
        XCTAssertEqual(["1", "2", "3"], try input.toUtf8Data().toArray())

        input = "{\"1\":\"100\",\"2\":\"200\"}"
        XCTAssertEqual(["1":"100", "2":"200"], try input.toUtf8Data().toJSONObject())
        XCTAssertEqual(["1":"100", "2":"200"], try input.toUtf8Data().toDictionary())

        //  Error
        input = "[1, \"2\", \"3\"]"
        XCTAssertThrowsError(try input.toUtf8Data().toJSONObject() as [String])
        XCTAssertThrowsError(try input.toUtf8Data().toArray() as [String])

        input = "{1:\"100\",\"2\":\"200\"}"
        XCTAssertThrowsError(try input.toUtf8Data().toJSONObject() as [String: Any])
        XCTAssertThrowsError(try input.toUtf8Data().toDictionary() as [String: Int])

        let image = TestBundle.image(name: "swift", type: "png")!
        let data = image.toPNG()!
        XCTAssertThrowsError(try data.toUtf8S())
    }

    func testConvertCharacter() {
        var chr: Character = "a"
        XCTAssertEqual(chr.toAscii(), 97)
        XCTAssertEqual(chr.toS(), "a")
        chr = "A"
        XCTAssertEqual(chr.toAscii(), 65)
        XCTAssertEqual(chr.toS(), "A")
    }

}
