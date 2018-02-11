//
//  CGFloatExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class CGFloatExtensionsTests: XCTestCase {

    func testConstants() {
        XCTAssertEqual(CGFloat.defaultMargin, 15)
        XCTAssertEqual(CGFloat.defaultCellHeight, 45)
        XCTAssertEqual(CGFloat.defaultBorderWidth, 0.5)
        XCTAssertEqual(CGFloat.automaticDimension, UITableViewAutomaticDimension)

    }
}
