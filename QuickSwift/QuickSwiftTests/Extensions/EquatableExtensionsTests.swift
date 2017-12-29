//
//  EquatableExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class TestObjectEqualModel: ObjectEquatable {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class EquatableExtensionsTests: XCTestCase {

    func testEquatable() {
        let model1 = TestObjectEqualModel(name: "tcui")
        let model2 = model1

        XCTAssertEqual(model1.name, model2.name)

        XCTAssertTrue(model1 === model2)
        XCTAssertTrue(model1 == model2)

        model2.name = "book"
        XCTAssertEqual(model1.name, model2.name)
        XCTAssertEqual(model1.name, "book")

        XCTAssertTrue(model1 === model2)
        XCTAssertTrue(model1 == model2)
    }

}
