//
//  UIDeviceExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIDeviceExtensionsTests: XCTestCase {

    func testExample() {
        print("111111")
        //  "unknown"
        XCTAssertFalse(UIDevice.current.isPortrait)
        XCTAssertFalse(UIDevice.current.isLandscape)

        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            XCTAssertTrue(UIDevice.current.isIPhone)
            XCTAssertFalse(UIDevice.current.isIPad)
        case .pad:
            XCTAssertFalse(UIDevice.current.isIPhone)
            XCTAssertTrue(UIDevice.current.isIPad)
        default:
            break
        }

    }

}
