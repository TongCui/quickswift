//
//  UIColorExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIColorExtensionsTests: XCTestCase {

    func testRandomColor() {
        let colors = (0..<10).reduce(into: [UIColor]()) { (result, idx) in
            let color = UIColor.random
            result.append(color)
        }
        XCTAssertTrue(colors.uniqued().count > 1)
    }

    func testRgbComponents() {
        let color = UIColor(red: 0, green: 50, blue: 100)!
        let components = color.rgbComponents

        XCTAssertEqual(components.red, 0)
        XCTAssertEqual(components.green, 50)
        XCTAssertEqual(components.blue, 100)
    }

    func testCGRgbComponents() {
        let color = UIColor(red: 0.1, green: 0.3, blue: 0.4, alpha: 1)
        let components = color.cgFloatComponents

        XCTAssertEqual(components.red, 0.1)
        XCTAssertEqual(components.green, 0.3)
        XCTAssertEqual(components.blue, 0.4)
    }

    func testAlpha() {
        let color = UIColor(red: 0.1, green: 0.3, blue: 0.4, alpha: 0.1)
        XCTAssertEqual(0.1, color.alpha)
    }

    func testHexString() {
        let color = UIColor(red: 255, green: 255, blue: 255)!
        XCTAssertEqual("#FFFFFF", color.hexString)
    }

    func testShortHexString() {
        var color = UIColor(red: 255, green: 255, blue: 255)!
        XCTAssertEqual("#FFF", color.shortHexString!)

        color = UIColor(red: 123, green: 111, blue: 182)!
        XCTAssertNil(color.shortHexString)
    }

    func testHexColor() {
        var color = UIColor(hex: 0xFFFFFF, transparency: 0.2)!
        XCTAssertEqual(color.rgbComponents.red, 255)
        XCTAssertEqual(color.rgbComponents.green, 255)
        XCTAssertEqual(color.rgbComponents.blue, 255)
        XCTAssertEqual(color.alpha, 0.2)

        color = UIColor(hexString: "#FFFFFF", transparency: 0.2)!
        XCTAssertEqual(color.rgbComponents.red, 255)
        XCTAssertEqual(color.rgbComponents.green, 255)
        XCTAssertEqual(color.rgbComponents.blue, 255)
        XCTAssertEqual(color.alpha, 0.2)

        color = UIColor(hexString: "0xFFFFFF", transparency: 0.2)!
        XCTAssertEqual(color.rgbComponents.red, 255)
        XCTAssertEqual(color.rgbComponents.green, 255)
        XCTAssertEqual(color.rgbComponents.blue, 255)
        XCTAssertEqual(color.alpha, 0.2)

        color = UIColor(hexString: "#FFF", transparency: 0.2)!
        XCTAssertEqual(color.rgbComponents.red, 255)
        XCTAssertEqual(color.rgbComponents.green, 255)
        XCTAssertEqual(color.rgbComponents.blue, 255)
        XCTAssertEqual(color.alpha, 0.2)
    }

}
