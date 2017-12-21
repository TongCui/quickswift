//
//  SignedIntegerExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class SignedIntegerExtensionsTests: XCTestCase {
    let intP: Int = 10
    let intN: Int = -10

    func testAbs() {
        XCTAssertEqual(intP.abs, 10)
        XCTAssertEqual(intN.abs, 10)
    }

    func testPositive() {
        XCTAssertTrue(intP.isPositive)
        XCTAssertFalse(intN.isPositive)
    }

    func testNegative() {
        XCTAssertFalse(intP.isNegative)
        XCTAssertTrue(intN.isNegative)
    }

    func testEven() {
        XCTAssertTrue(0.isEven)
        XCTAssertTrue(2.isEven)
        XCTAssertTrue((-2).isEven)
        XCTAssertTrue(1000.isEven)

        XCTAssertFalse(1.isEven)
        XCTAssertFalse(3.isEven)
        XCTAssertFalse((-3).isEven)
        XCTAssertFalse(1001.isEven)
    }

    func testOdd() {
        XCTAssertFalse(0.isOdd)
        XCTAssertFalse(2.isOdd)
        XCTAssertFalse((-2).isOdd)
        XCTAssertFalse(1000.isOdd)

        XCTAssertTrue(1.isOdd)
        XCTAssertTrue(3.isOdd)
        XCTAssertTrue((-3).isOdd)
        XCTAssertTrue(1001.isOdd)
    }

    func testDigits() {
        XCTAssertEqual(123.digits, [1, 2, 3])
        XCTAssertEqual((-123).digits, [1, 2, 3])
    }

    func testDigitsCount() {
        XCTAssertEqual(123.digitsCount, 3)
        XCTAssertEqual((-123).digitsCount, 3)
    }

    func testGcd() {
        XCTAssertEqual(6.gcd(of: 12), 6)
        XCTAssertEqual(8.gcd(of: 12), 4)
        XCTAssertEqual(12.gcd(of: 12), 12)
    }

    func testLcm() {
        XCTAssertEqual(6.lcm(of: 12), 12)
        XCTAssertEqual(8.lcm(of: 12), 24)
        XCTAssertEqual(12.lcm(of: 12), 12)
    }
}
