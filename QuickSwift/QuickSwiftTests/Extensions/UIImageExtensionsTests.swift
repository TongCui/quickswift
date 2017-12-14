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

    let image: UIImage = TestBundle.image(name: "swift", type: "png")!

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

}
