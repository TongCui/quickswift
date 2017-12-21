//
//  SwizzleTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 19/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class SwizzleTests: XCTestCase {

    func testSwizzleInstanceMethod() {

        let orig: Selector = #selector(SwizzleDemo.testInstanceMethod(value:))
        let alter: Selector = #selector(SwizzleDemo.swizzle_testInstanceMethod(value:))

        XCTAssertEqual(SwizzleDemo().testInstanceMethod(value: 20), "SwizzleDemo.testInstanceMethod(value: 20)")
        XCTAssertEqual(SwizzleDemo().swizzle_testInstanceMethod(value: 20), "SwizzleDemo.swizzle_testInstanceMethod(value: 20)")

        Swizzle.swizzleInstanceMethods(forClass: SwizzleDemo.self, orig, alter)
        XCTAssertEqual(SwizzleDemo().testInstanceMethod(value: 10), "SwizzleDemo.swizzle_testInstanceMethod(value: 10)")
        XCTAssertEqual(SwizzleDemo().swizzle_testInstanceMethod(value: 10), "SwizzleDemo.testInstanceMethod(value: 10)")
    }

    func testSwizzleClassMethod() {

        let orig: Selector = #selector(SwizzleDemo.testClassMethod)
        let alter: Selector = #selector(SwizzleDemo.swizzle_testClassMethod)

        XCTAssertEqual(SwizzleDemo.testClassMethod(), "SwizzleDemo.testClassMethod()")
        XCTAssertEqual(SwizzleDemo.swizzle_testClassMethod(), "SwizzleDemo.swizzle_testClassMethod()")

        Swizzle.swizzleClassMethods(forClass: SwizzleDemo.self, orig, alter)
        XCTAssertEqual(SwizzleDemo.testClassMethod(), "SwizzleDemo.swizzle_testClassMethod()")
        XCTAssertEqual(SwizzleDemo.swizzle_testClassMethod(), "SwizzleDemo.testClassMethod()")

    }

}
