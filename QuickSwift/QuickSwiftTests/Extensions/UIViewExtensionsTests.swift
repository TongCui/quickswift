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

    func testPositionsGet() {
        XCTAssertEqual(view.top, 10)
        XCTAssertEqual(view.bottom, 210)
        XCTAssertEqual(view.left, 10)
        XCTAssertEqual(view.right, 110)
        XCTAssertEqual(view.width, 100)
        XCTAssertEqual(view.height, 200)
        XCTAssertEqual(view.midX, 60)
        XCTAssertEqual(view.midY, 110)
    }

    func testPositionsSet() {
        view.frame = CGRect.zero
        view.top = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))

        view.frame = CGRect.zero
        view.bottom = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))

        view.frame = CGRect.zero
        view.left = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.right = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.width = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 10, height: 0))

        view.frame = CGRect.zero
        view.height = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 0, height: 10))

        view.frame = CGRect.zero
        view.midX = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.midY = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))
    }

    func testVisible() {
        XCTAssertFalse(view.isVisible)

        let window = UIWindow(frame: CGRect.zero)
        window.addSubview(view)

        XCTAssertTrue(view.isVisible)
    }

}
