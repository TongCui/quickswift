//
//  SwizzleDemo.swift
//  QuickSwiftTests
//
//  Created by tcui on 19/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation
@testable import QuickSwift

class SwizzleDemo: NSObject {

}

extension SwizzleDemo {
    @objc
    class func testClassMethod() -> String {
        return "SwizzleDemo.testClassMethod()"
    }

    @objc
    func testInstanceMethod(value: Int) -> String {
        return "SwizzleDemo.testInstanceMethod(value: \(value))"
    }

    @objc
    class func swizzle_testClassMethod() -> String {
        return "SwizzleDemo.swizzle_testClassMethod()"
    }

    @objc
    func swizzle_testInstanceMethod(value: Int) -> String {
        return "SwizzleDemo.swizzle_testInstanceMethod(value: \(value))"
    }
}
