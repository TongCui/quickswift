//
//  NSObjectExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class NSObjectExtensionsTests: XCTestCase {

    func testClassName() {
        XCTAssertEqual(self.className, "QuickSwiftTests.NSObjectExtensionsTests")
        XCTAssertEqual(self.classNameShort, "NSObjectExtensionsTests")
    }

}
