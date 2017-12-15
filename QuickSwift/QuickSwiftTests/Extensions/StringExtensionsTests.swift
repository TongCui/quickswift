//
//  StringExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class StringExtensionsTests: XCTestCase {

    func testFileName() {
        var file = "image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "./book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = ".//book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "image.tmp.png"
        XCTAssertEqual(file.fileName, "image.tmp")
        XCTAssertEqual(file.fileExtension, "png")

        file = "image"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "")
    }

}
