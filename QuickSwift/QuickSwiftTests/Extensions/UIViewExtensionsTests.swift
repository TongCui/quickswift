//
//  UIViewExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIViewExtensionsTests: XCTestCase {

    let view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 200))

    func testPositions() {
        XCTAssertEqual(view.top, 10)
        XCTAssertEqual(view.bottom, 210)
        XCTAssertEqual(view.left, 10)
        XCTAssertEqual(view.right, 110)
        XCTAssertEqual(view.width, 100)
        XCTAssertEqual(view.height, 200)
        XCTAssertEqual(view.midX, 60)
        XCTAssertEqual(view.midY, 110)
    }

    func testVisible() {
        XCTAssertFalse(view.isVisible)

        let window = UIWindow(frame: CGRect.zero)
        window.addSubview(view)

        XCTAssertTrue(view.isVisible)
    }

}
