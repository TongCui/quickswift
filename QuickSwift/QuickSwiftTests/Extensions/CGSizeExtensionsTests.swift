//
//  CGSizeExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class CGSizeExtensionsTests: XCTestCase {

    func testInitWithSide() {
        XCTAssertEqual(CGSize(width: 10, height: 10), CGSize(side: 10))
    }

    func testOrientation() {
        var size = CGSize(width: 100, height: 100)
        XCTAssertTrue(size.isSquare)
        XCTAssertFalse(size.isPortrait)
        XCTAssertFalse(size.isLandscape)

        size = CGSize(width: 100, height: 10)
        XCTAssertFalse(size.isSquare)
        XCTAssertFalse(size.isPortrait)
        XCTAssertTrue(size.isLandscape)

        size = CGSize(width: 10, height: 100)
        XCTAssertFalse(size.isSquare)
        XCTAssertTrue(size.isPortrait)
        XCTAssertFalse(size.isLandscape)
    }

}
