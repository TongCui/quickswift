//
//  FibonacciTestCases.swift
//  QuickSwiftTests
//
//  Created by tcui on 5/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class FibonacciTestCases: XCTestCase {

    func testFibonacciSequence() {
        var fibo = Array(FibonacciSequence(startsFromZero: true).prefix(10))
        XCTAssertEqual([0, 1, 1, 2, 3, 5, 8, 13, 21, 34], fibo)

        fibo = Array(FibonacciSequence(startsFromZero: false).prefix(10))
        XCTAssertEqual([1, 1, 2, 3, 5, 8, 13, 21, 34, 55], fibo)

    }

    func testFibonacci() {
        var fibo = Fibonacci.prefix(10, startsFromZero: true)
        XCTAssertEqual([0, 1, 1, 2, 3, 5, 8, 13, 21, 34], fibo)

        fibo = Fibonacci.prefix(10)
        XCTAssertEqual([1, 1, 2, 3, 5, 8, 13, 21, 34, 55], fibo)
    }

    func testFibonacciSequencePerformance() {
        // This is an example of a performance test case.
        self.measure {
            _ = Array(FibonacciSequence(startsFromZero: true).prefix(30))
        }
    }

}
