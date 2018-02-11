//
//  UIEdgeInsetsExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIEdgeInsetsExtensionsTests: XCTestCase {

    func testInitWithMargin() {
        let margin: CGFloat = 10
        XCTAssertEqual(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin), UIEdgeInsets(margin: margin))
    }

    func testInitWithTopLeft() {
        let top: CGFloat = 10
        let left: CGFloat = 20
        XCTAssertEqual(UIEdgeInsets(top: top, left: left, bottom: top, right: left), UIEdgeInsets(top: top, left: left))
    }

    func testIsSameMargin() {
        var edgeInsets = UIEdgeInsets(margin: 10)
        XCTAssertTrue(edgeInsets.isSameMargin)

        edgeInsets = UIEdgeInsets(top: 10, left: 20)
        XCTAssertFalse(edgeInsets.isSameMargin)

        edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        XCTAssertFalse(edgeInsets.isSameMargin)
    }
}
