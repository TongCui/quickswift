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

        input = 0
        XCTAssertEqual(input.toF(), 0)
        XCTAssertEqual(input.toD(), 0)
        XCTAssertEqual(input.toS(), "0")

        input = -1
        XCTAssertEqual(input.toF(), -1)
        XCTAssertEqual(input.toD(), -1)
        XCTAssertEqual(input.toS(), "-1")
        
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
    }

    func testConvertData() {
        var string = "abc"

        XCTAssertEqual(string.toUtf8Data().count, 3)
        XCTAssertEqual(try string.toUtf8Data().toUtf8S(), "abc")

        string = "Não, l'été c'est pour bientôt"
        XCTAssertTrue(string.toUtf8Data().count > 10)
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
