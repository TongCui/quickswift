//
//  UIControlExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIControlExtensionsTests: XCTestCase {

    func testExample() {
        let button = UIButton(frame: CGRect.zero)
        XCTAssertTrue(button.allTargets.isEmpty)
        button.addHandler(for: .touchUpInside) { (sender: UIButton) in
            print("button did press \(sender)")
        }
        XCTAssertFalse(button.allTargets.isEmpty)
    }

}
