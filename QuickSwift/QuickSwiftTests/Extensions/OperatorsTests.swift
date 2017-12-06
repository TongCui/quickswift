//
//  OperatorsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class OperatorsTests: XCTestCase {

    func testPowerOperator() {
        let intValue: Int = 5
        let floatValue: Float = 5
        let doubleValue: Double = 5

        XCTAssertEqual(intValue ** 2, 25)
        XCTAssertEqual(floatValue ** 2, 25)
        XCTAssertEqual(doubleValue ** 2, 25)
        XCTAssertEqual(3 ** 4, 81)
    }

}
