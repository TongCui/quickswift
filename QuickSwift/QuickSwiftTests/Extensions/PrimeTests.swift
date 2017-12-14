//
//  PrimeTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class PrimeTests: XCTestCase {

    func testIntPrime() {
        XCTAssertTrue(2.isPrime)
        XCTAssertTrue(3.isPrime)
        XCTAssertTrue(11.isPrime)
        XCTAssertTrue(17.isPrime)

        XCTAssertFalse(1.isPrime)
        XCTAssertFalse((-5).isPrime)
        XCTAssertFalse(4.isPrime)
        XCTAssertFalse(100.isPrime)
        XCTAssertFalse(261.isPrime)
    }

    func testIntPrimeList() {
        XCTAssertEqual(Int.primes(first: -10), [])
        XCTAssertEqual(Int.primes(first: 0), [])
        XCTAssertEqual(Int.primes(first: 1), [2])
        XCTAssertEqual(Int.primes(first: 10), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29])
        XCTAssertEqual(Int.primes(first: 100), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541] )
    }

}
