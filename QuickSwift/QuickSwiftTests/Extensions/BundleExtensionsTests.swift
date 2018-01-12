//
//  BundleExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 12/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class BundleExtensionsTests: XCTestCase {

    func testBundleImage() {
        XCTAssertNil(Bundle.test.image(name: "none"))
        XCTAssertNil(Bundle.test.image(name: "swift"))
        XCTAssertNotNil(Bundle.test.image(name: "swift", type: "png"))
        XCTAssertNil(Bundle.test.image(name: "swift", type: "jpeg"))
    }
}
