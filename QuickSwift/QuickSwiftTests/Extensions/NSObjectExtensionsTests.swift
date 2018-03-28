//
//  NSObjectExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
import UIKit
@testable import QuickSwift

class MyViewController: UIViewController { }
class SwiftClass: TypeName { }
class MySwiftClass: SwiftClass { }

class NSObjectExtensionsTests: XCTestCase {

    func testClassName() {
        XCTAssertEqual(self.classNameFull, "QuickSwiftTests.NSObjectExtensionsTests")
        XCTAssertEqual(self.className, "NSObjectExtensionsTests")
        XCTAssertEqual(type(of: self).typeName, "NSObjectExtensionsTests")
    }

    func testTypeName() {

        XCTAssertEqual("MyViewController", MyViewController.typeName)
        XCTAssertEqual("UIViewController", UIViewController.typeName)

        let myVC = MyViewController()
        XCTAssertEqual("MyViewController", type(of: myVC).typeName)

        let VC = UIViewController()
        XCTAssertEqual("UIViewController", type(of: VC).typeName)

        XCTAssertEqual("String", String.typeName)
        XCTAssertEqual("SwiftClass", SwiftClass.typeName)
        XCTAssertEqual("MySwiftClass", MySwiftClass.typeName)
    }

}
