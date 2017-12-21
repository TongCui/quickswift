//
//  UserDefaultsExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UserDefaultsExtensionsTests: XCTestCase {

    let userDefault = UserDefaults.standard

    override func setUp() {
        super.setUp()
        userDefault.removeObject(forKey: "string")
        userDefault.removeObject(forKey: "int")
    }

    override func tearDown() {
        super.tearDown()
        userDefault.removeObject(forKey: "string")
        userDefault.removeObject(forKey: "int")
    }

    func testSubscript() {
        userDefault["string"] = "string"
        userDefault["int"] = 12

        let stringValue: String? = userDefault["string"]

        XCTAssertEqual(stringValue, "string")

        let intValue: Int? = userDefault["int"]

        XCTAssertEqual(intValue, 12)
    }

}
