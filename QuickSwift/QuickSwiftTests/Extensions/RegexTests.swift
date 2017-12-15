//
//  RegexTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class RegexTests: XCTestCase {

    let invalidPattern = "[UserColor-17]"

    func testString() {
        var pattern = "\\d"
        XCTAssertNotNil(try pattern.toR())
        XCTAssertNotNil(try pattern.toRi())

        pattern = invalidPattern
        XCTAssertThrowsError(try pattern.toR())
        XCTAssertThrowsError(try pattern.toRi())
    }

    func testMatch() {
        var pattern = "\\d"

        XCTAssertTrue(try pattern.toR().match(input: "123"))
        XCTAssertTrue(try pattern.toR().match(input: "123abc123"))
        XCTAssertFalse(try pattern.toR().match(input: "abc"))

        pattern = "(ab)+"
        XCTAssertFalse(try pattern.toR().match(input: "123"))
        XCTAssertTrue(try pattern.toR().match(input: "123abc123"))
        XCTAssertTrue(try pattern.toR().match(input: "abc"))

        XCTAssertFalse(try pattern.toRi().match(input: "123"))
        XCTAssertTrue(try pattern.toRi().match(input: "123abc123"))
        XCTAssertTrue(try pattern.toRi().match(input: "abc"))
    }

    func testOperator() {
        var pattern = "\\d"

        XCTAssertTrue("123" =~ pattern)
        XCTAssertTrue("123abc123" =~ pattern)
        XCTAssertFalse("abc" =~ pattern)
        XCTAssertFalse("123" !~ pattern)
        XCTAssertFalse("123abc123" !~ pattern)
        XCTAssertTrue("abc" !~ pattern)

        pattern = "(ab)+"
        XCTAssertFalse("123" =~ pattern)
        XCTAssertTrue("123abc123" =~ pattern)
        XCTAssertTrue("abc" =~ pattern)
        XCTAssertTrue("123" !~ pattern)
        XCTAssertFalse("123abc123" !~ pattern)
        XCTAssertFalse("abc" !~ pattern)

        pattern = invalidPattern
        XCTAssertFalse("abc" =~ pattern)
        XCTAssertTrue("abc" !~ pattern)
    }

}
