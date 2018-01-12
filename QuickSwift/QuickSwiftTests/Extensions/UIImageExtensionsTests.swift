//
//  UIImageExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIImageExtensionsTests: XCTestCase {

    let image: UIImage = Bundle.test.image(name: "swift", type: "png")!

    func testToData() {
        XCTAssertNotNil(image.toPNG())
        XCTAssertNotNil(image.toJPEG())
    }

    func testToImage() {
        var data = image.toPNG()
        XCTAssertNotNil(data)
        XCTAssertNotNil(data?.toImage())

        data = image.toJPEG()
        XCTAssertNotNil(data)
        XCTAssertNotNil(data?.toImage())
    }

    func testSize() {
        XCTAssertEqual(image.width, 40)
        XCTAssertEqual(image.height, 40)
    }

}
