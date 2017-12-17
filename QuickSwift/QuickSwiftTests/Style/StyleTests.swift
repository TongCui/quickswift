//
//  StyleTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class StyleTests: XCTestCase {

    let label = UILabel()
    let button = UIButton()
    let imageView = UIImageView()

    let styleItem: StyleItem<UILabel> = StyleItem { (label) in
        label.textAlignment = .center
    }

    override func setUp() {
        super.setUp()
        label.backgroundColor = UIColor.red
        button.backgroundColor = UIColor.green
        imageView.backgroundColor = UIColor.blue
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSyntax() {
        label.style.with([LabelStyles.leftLabel.styleItem, LabelStyles.rightLabel.styleItem])
        label.style.with(LabelStyles.centerLabel, LabelStyles.rightLabel)

        button.style.with(ButtonStyles.greenButton, .redButton)
        button.style.with(ButtonStyles.self, .greenButton, .redButton)
    }

    func testStylable() {
        XCTAssertNotNil(label.style)
        XCTAssertNotNil(button.style)
        XCTAssertNotNil(imageView.style)
    }

    func testStyableCopyStyle() {
        let newLabel = UILabel()
        newLabel.copyStyle(label)
        XCTAssertEqual(newLabel.backgroundColor, .red)

        let newButton = UIButton()
        newButton.copyStyle(button)
        XCTAssertEqual(newButton.backgroundColor, .green)

        let newImageView = UIImageView()
        newImageView.copyStyle(imageView)
        XCTAssertEqual(newImageView.backgroundColor, .blue)
    }

    func testStyleSame() {
        let newLabel = UILabel()
        newLabel.style.same(with: label)
        XCTAssertEqual(newLabel.backgroundColor, .red)

        let newButton = UIButton()
        newButton.style.same(with: button)
        XCTAssertEqual(newButton.backgroundColor, .green)

        let newImageView = UIImageView()
        newImageView.style.same(with: imageView)
        XCTAssertEqual(newImageView.backgroundColor, .blue)
    }

    func testStyleWith() {
        label.style.with(LabelStyles.leftLabel, .redLabel)
        XCTAssertEqual(label.textAlignment, .left)
        XCTAssertEqual(label.textColor, .red)

        label.style.with(LabelStyles.self, .rightLabel, .greenLabel)
        XCTAssertEqual(label.textAlignment, .right)
        XCTAssertEqual(label.textColor, .green)

        button.style.with(ButtonStyles.greenButton, .redButton)
        XCTAssertEqual(button.titleColor(for: .normal), .red)
        button.style.with(ButtonStyles.redButton, .greenButton)
        XCTAssertEqual(button.titleColor(for: .normal), .green)

        imageView.style.with(ImageViewStyles.greenTintImageView)
        XCTAssertEqual(imageView.tintColor, .green)

        imageView.style.with(ImageViewStyles.redTintImageView)
        XCTAssertEqual(imageView.tintColor, .red)
    }

    func testStyleWithItem() {
        label.style.with([styleItem])
        XCTAssertEqual(label.textAlignment, .center)
    }

    func testStyleUICustom() {
        label.style.ui { (label) in
            label.textAlignment = .center
        }
        XCTAssertEqual(label.textAlignment, .center)
    }

}
