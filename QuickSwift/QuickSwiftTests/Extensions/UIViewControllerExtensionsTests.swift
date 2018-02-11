//
//  UIViewControllerExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIViewControllerExtensionsTests: XCTestCase {

    func testSetLargeTitle() {
        let viewControler = UIViewController()
        let naviController = UINavigationController(rootViewController: viewControler)

        viewControler.setLargetTitles(true)
        XCTAssertTrue(naviController.navigationBar.prefersLargeTitles)

        viewControler.setLargetTitles(false)
        XCTAssertFalse(naviController.navigationBar.prefersLargeTitles)
    }

}
