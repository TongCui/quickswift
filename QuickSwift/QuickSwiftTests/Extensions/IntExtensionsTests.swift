//
//  IntExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 8/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class IntExtensionsTests: XCTestCase {

    func testIntEven() {
        XCTAssertTrue(0.isEven)
        XCTAssertTrue(2.isEven)
        XCTAssertTrue((-2).isEven)
        XCTAssertTrue(100.isEven)

        XCTAssertFalse(1.isEven)
        XCTAssertFalse((-1).isEven)
        XCTAssertFalse(101.isEven)
    }

    func testIntOdd() {
        XCTAssertFalse(0.isOdd)
        XCTAssertFalse(2.isOdd)
        XCTAssertFalse((-2).isOdd)
        XCTAssertFalse(100.isOdd)

        XCTAssertTrue(1.isOdd)
        XCTAssertTrue((-1).isOdd)
        XCTAssertTrue(101.isOdd)
    }

    func testTimes() {
        var array = [Int]()

        1.times { array.append($0) }
        XCTAssertEqual(array, [0])

        array.removeAll()
        5.times { array.append($0) }
        XCTAssertEqual(array, [0, 1, 2, 3, 4])

        array.removeAll()
        0.times { array.append($0) }
        XCTAssertEqual(array, [])
    }

    func testUpto() {
        var array = [Int]()

        0.upto(0) { array.append($0) }
        XCTAssertEqual(array, [0])

        array.removeAll()
        0.upto(1) { array.append($0) }
        XCTAssertEqual(array, [0, 1])

        array.removeAll()
        1.upto(5) { array.append($0) }
        XCTAssertEqual(array, [1, 2, 3, 4, 5])

        array.removeAll()
        (-1).upto(5) { array.append($0) }
        XCTAssertEqual(array, [-1, 0, 1, 2, 3, 4, 5])

        array.removeAll()
        (-1).upto(-10) { array.append($0) }
        XCTAssertEqual(array, [])
    }

    func testDownto() {
        var array = [Int]()

        0.downto(0) { array.append($0) }
        XCTAssertEqual(array, [0])

        array.removeAll()
        1.downto(0) { array.append($0) }
        XCTAssertEqual(array, [1, 0])

        array.removeAll()
        5.downto(1) { array.append($0) }
        XCTAssertEqual(array, [5, 4, 3, 2, 1])

        array.removeAll()
        (-1).downto(-5) { array.append($0) }
        XCTAssertEqual(array, [-1, -2, -3, -4, -5])

        array.removeAll()
        (-1).downto(10) { array.append($0) }
        XCTAssertEqual(array, [])
    }
}
