//
//  BoolExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class BoolExtensionsTests: XCTestCase {

    func testToggle() {
        var bool = true

        XCTAssertEqual(bool.toggled, false)
        XCTAssertEqual(bool.toggled, false)

        bool = true
        bool.toggle()
        XCTAssertEqual(bool, false)
        bool.toggle()
        XCTAssertEqual(bool, true)
    }

}
