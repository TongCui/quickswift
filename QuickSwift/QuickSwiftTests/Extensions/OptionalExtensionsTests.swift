//
//  OptionalExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 2/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class OptionalExtensionsTests: XCTestCase {

    func testIsNil() {
        var value: Int?
        XCTAssertTrue(value.isNil)
        value = 12
        XCTAssertFalse(value.isNil)
    }
}
