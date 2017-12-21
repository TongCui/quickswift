//
//  CollectionExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class CollectionExtensionsTests: XCTestCase {

    let array = [1, 2, 3, 4, 5]

    func testSafeSubscript() {
        XCTAssertEqual(array[safe: 2], 3)
        XCTAssertEqual(array[safe: 10], nil)

    }

    func testRandomItem() {
        var result = [Int]()
        1.upto(100) { _ in result.append(array.randomItem) }
        print("result is \(result)")
        XCTAssertTrue(result.any(where: { $0 == 1 }))
        XCTAssertTrue(!result.all(where: { $0 == 1 }))
    }

}
