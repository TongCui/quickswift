//
//  DataExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 9/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class DataExtensionsTests: XCTestCase {

    func testExample() {
        let plain = "Hello!!!"
        let encryptedData = plain.toUtf8Data().simpleEncrypted(offset: 200)
        XCTAssertFalse(encryptedData.isEmpty)
        let now = try! encryptedData.simpleDecrypted(offset: 200).toUtf8S()
        XCTAssertEqual(now, plain)
    }
}
