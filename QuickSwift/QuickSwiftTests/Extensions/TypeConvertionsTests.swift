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

    func testConvertFromInt() {
        var input: Int = 1
        XCTAssertEqual(input.toI, 1)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "1")

        input = 0
        XCTAssertEqual(input.toI, 0)
        XCTAssertEqual(input.toF, 0)
        XCTAssertEqual(input.toD, 0)
        XCTAssertEqual(input.toS, "0")

        input = -1
        XCTAssertEqual(input.toI, -1)
        XCTAssertEqual(input.toF, -1)
        XCTAssertEqual(input.toD, -1)
        XCTAssertEqual(input.toS, "-1")
    }

    func testConvertFromFloat() {
        var input: Float = 1.0
        XCTAssertEqual(input.toI, 1)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "1.0")

        input = 0
        XCTAssertEqual(input.toI, 0)
        XCTAssertEqual(input.toF, 0)
        XCTAssertEqual(input.toD, 0)
        XCTAssertEqual(input.toS, "0.0")

        input = -1
        XCTAssertEqual(input.toI, -1)
        XCTAssertEqual(input.toF, -1)
        XCTAssertEqual(input.toD, -1)
        XCTAssertEqual(input.toS, "-1.0")
    }

    func testConvertFromDouble() {
        var input: Double = 1.0
        XCTAssertEqual(input.toI, 1)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "1.0")

        input = 0
        XCTAssertEqual(input.toI, 0)
        XCTAssertEqual(input.toF, 0)
        XCTAssertEqual(input.toD, 0)
        XCTAssertEqual(input.toS, "0.0")

        input = -1
        XCTAssertEqual(input.toI, -1)
        XCTAssertEqual(input.toF, -1)
        XCTAssertEqual(input.toD, -1)
        XCTAssertEqual(input.toS, "-1.0")
    }

    func testConvertFromString() {
        var input: String = "1"
        XCTAssertEqual(input.toI, 1)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "1")

        input = "+1"
        XCTAssertEqual(input.toI, 1)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "+1")

        input = "1.0"
        XCTAssertEqual(input.toI, nil)
        XCTAssertEqual(input.toF, 1.0)
        XCTAssertEqual(input.toD, 1.0)
        XCTAssertEqual(input.toS, "1.0")

        input = "0"
        XCTAssertEqual(input.toI, 0)
        XCTAssertEqual(input.toF, 0)
        XCTAssertEqual(input.toD, 0)
        XCTAssertEqual(input.toS, "0")

        input = "-0"
        XCTAssertEqual(input.toI, 0)
        XCTAssertEqual(input.toF, 0)
        XCTAssertEqual(input.toD, 0)
        XCTAssertEqual(input.toS, "-0")

        input = "-1"
        XCTAssertEqual(input.toI, -1)
        XCTAssertEqual(input.toF, -1)
        XCTAssertEqual(input.toD, -1)
        XCTAssertEqual(input.toS, "-1")

        input = "abc"
        XCTAssertEqual(input.toI, nil)
        XCTAssertEqual(input.toF, nil)
        XCTAssertEqual(input.toD, nil)
        XCTAssertEqual(input.toS, "abc")
    }

    func testStringInit() {
        XCTAssertEqual(String("abc")!, "abc")
    }

    func testConvertData() {
        let string = "abc"

        XCTAssertEqual(string.toData?.count, 3)
        XCTAssertEqual(string.toData?.toS, "abc")
    }

}
