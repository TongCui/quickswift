//
//  RandomTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 8/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class RandomTests: XCTestCase {

    func testRandoms() {
        XCTAssertNotNil(Bool.random())
        XCTAssertNotNil(5.random)
        XCTAssertNotNil(Int.random())
        XCTAssertNotNil(Int.random(1...3))
        XCTAssertNotNil(Int.random(1..<3))
        XCTAssertNotNil(String.random(ofLength: 10))
        XCTAssertNotNil(String.random(withCharactersInString: "abcde", min: 1, max: 5))
        XCTAssertNotNil(String.random(withCharactersInString: "abcde", min: 5, max: 1))
        XCTAssertNotNil(String.random(withCharactersInString: "abcde", ofLength: 10))
        XCTAssertNotNil(Date.random())
        XCTAssertNotNil(Date.randomWithinDaysBeforeToday(7))
        XCTAssertNotNil(CGFloat.random())
        XCTAssertNotNil(Float.random())
        XCTAssertNotNil(Double.random())
        XCTAssertNotNil(UIColor.random())
        XCTAssertNotNil(UIColor.random(includingAlpha:true))
        XCTAssertNotNil(UIColor.random(includingAlpha:false))
        XCTAssertNotNil([1, 2, 3].randomItem())
        XCTAssertNil([].randomItem())
    }

}
