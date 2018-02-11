//
//  UIImageViewExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIImageViewExtensionsTests: XCTestCase {

    let image: UIImage = Bundle.test.image(name: "google", type: "png")!

    func testUpdateAutoLayoutHeight() {
        let imageView = UIImageView(image: image)
        let height: CGFloat = 99
        imageView.updateAutolayout(imageHeight: .height(height))
        XCTAssertTrue(imageView.constraints.any(where: { (constraint) -> Bool in
            constraint.constant == height
        }))
    }

    func testUpdateAutoLayoutRatioNoImage() {
        let imageView = UIImageView()
        imageView.updateAutolayout(imageHeight: .imageRatio)
        XCTAssertTrue(imageView.constraints.isEmpty)
    }

    func testUpdateAutoLayoutRatio() {
        let imageView = UIImageView(image: image)
        let width: CGFloat = 100
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.updateAutolayout(imageHeight: .imageRatio)

        let ratio: CGFloat = 20 / 92

        XCTAssertTrue(imageView.constraints.any(where: { (constraint) -> Bool in

            constraint.multiplier - ratio <= 0.001
        }))
    }

    func testUpdateToPreferred() {
        let imageView = UIImageView()
        image.preferredColor = .red
        image.preferredSize = CGSize(width: 100, height: 200)

        imageView.updateToPreferred(image)
        XCTAssertEqual(imageView.tintColor, .red)

    }

    func testImageHeightDescription() {
        XCTAssertEqual("height_100.0", UIImageView.ImageHeight.height(100).description)
        XCTAssertEqual("image_ratio", UIImageView.ImageHeight.imageRatio.description)
    }
}
