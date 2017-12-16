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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStyle() {
        var label = UILabel()

        label.style.with([LabelStyles.mainLabel.styleItem, LabelStyles.subLabel.styleItem])

        label = UILabel()
        label.style.make { (make) in
//            make.and(LabelStyles.mainLabel).and(LabelStyles.subLabel)
            make.and(.mainLabel).and(.subLabel)
        }

        label.style.with(.mainLabel, .subLabel)
    }

}
