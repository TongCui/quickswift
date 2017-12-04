//
//  ArrayExample.swift
//  QuickSwiftTests
//
//  Created by tcui on 4/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class ArrayExample: XCTestCase {

    var intArray = [Int]()
    var floatArray = [Float]()
    var doubleArray = [Double]()
    var stringArray = [String]()

    func testArrayProperties() {
        intArray = [1, 2, 3, 4, 5]

        XCTAssertEqual(false, intArray.isEmpty)
        XCTAssertEqual(5, intArray.count)
    }

    func testNonEmptyArray() {
        intArray = [1, 2, 3, 4, 5]
        floatArray = [1, 2, 3, 4, 5]
        doubleArray = [1, 2, 3, 4, 5]
        stringArray = ["1", "2", "3", "4", "5"]

        XCTAssertEqual(5, intArray.max())
        XCTAssertEqual(5, floatArray.max())
        XCTAssertEqual(5, doubleArray.max())
        XCTAssertEqual("5", stringArray.max())

        XCTAssertEqual(1, intArray.min())
        XCTAssertEqual(1, floatArray.min())
        XCTAssertEqual(1, doubleArray.min())
        XCTAssertEqual("1", stringArray.min())
    }

    func testEmptyArray() {
        intArray = []
        floatArray = []
        doubleArray = []
        stringArray = []

        XCTAssertEqual(nil, intArray.max())
        XCTAssertEqual(nil, floatArray.max())
        XCTAssertEqual(nil, doubleArray.max())
        XCTAssertEqual(nil, stringArray.max())

        XCTAssertEqual(nil, intArray.min())
        XCTAssertEqual(nil, floatArray.min())
        XCTAssertEqual(nil, doubleArray.min())
        XCTAssertEqual(nil, stringArray.min())
    }

    func testForLoop() {
        for value in intArray {
            print("value is \(value)")
        }

        for (index, value) in intArray.enumerated() {
            print("\(index) ) value is \(value)")
        }
    }

    func testFirstAndLast() {
        intArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(1, intArray.first)
        XCTAssertEqual(5, intArray.last)

        intArray = [1]
        XCTAssertEqual(1, intArray.first)
        XCTAssertEqual(1, intArray.last)

        intArray = []
        XCTAssertEqual(nil, intArray.first)
        XCTAssertEqual(nil, intArray.last)
    }

    func testAddingAndRemoving() {
        intArray = []

        intArray.append(1)
        XCTAssertEqual([1], intArray)

        intArray.append(contentsOf: [2, 3])
        XCTAssertEqual([1, 2, 3], intArray)

        intArray.insert(1, at: 1)
        XCTAssertEqual([1, 1, 2, 3], intArray)

        intArray.remove(at: 0)
        XCTAssertEqual([1, 2, 3], intArray)

        intArray.removeLast()
        XCTAssertEqual([1, 2], intArray)

        intArray.removeAll()
        XCTAssertEqual([], intArray)
    }

    func testSelectingElements() {
        intArray = [1, 2, 3, 4, 5]

        XCTAssertEqual([1, 2], intArray.prefix(2))
        XCTAssertEqual([1, 2, 3, 4], intArray.prefix(through: 3))
        XCTAssertEqual([1, 2, 3], intArray[...2])
        XCTAssertEqual([5], intArray.suffix(1))
    }

    func testCopyArray() {
        intArray = [1, 2, 3]
        var newArray = intArray
        newArray.append(4)

        XCTAssertEqual([1, 2, 3], intArray)
        XCTAssertEqual([1, 2, 3, 4], newArray)
    }

}
