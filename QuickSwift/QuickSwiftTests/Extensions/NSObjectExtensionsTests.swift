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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClassName() {
        print("\(self.className)")
        print("\(self.classNameShort)")

    }

}
