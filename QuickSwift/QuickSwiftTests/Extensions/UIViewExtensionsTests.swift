//
//  UIViewExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class UIViewExtensionsTests: XCTestCase {

    let view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 200))

    func testPositionsGet() {
        XCTAssertEqual(view.top, 10)
        XCTAssertEqual(view.bottom, 210)
        XCTAssertEqual(view.left, 10)
        XCTAssertEqual(view.right, 110)
        XCTAssertEqual(view.width, 100)
        XCTAssertEqual(view.height, 200)
        XCTAssertEqual(view.midX, 60)
        XCTAssertEqual(view.midY, 110)
    }

    func testPositionsSet() {
        view.frame = CGRect.zero
        view.top = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))

        view.frame = CGRect.zero
        view.bottom = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))

        view.frame = CGRect.zero
        view.left = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.right = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.width = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 10, height: 0))

        view.frame = CGRect.zero
        view.height = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 0, height: 10))

        view.frame = CGRect.zero
        view.midX = 10
        XCTAssertEqual(view.frame, CGRect(x: 10, y: 0, width: 0, height: 0))

        view.frame = CGRect.zero
        view.midY = 10
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 10, width: 0, height: 0))
    }

    func testVisible() {
        XCTAssertFalse(view.isVisible)

        let window = UIWindow(frame: CGRect.zero)
        window.addSubview(view)

        XCTAssertTrue(view.isVisible)
    }

    func testAllSubViews() {
        let view = UIView(frame: CGRect.zero)
        let h0_view0 = TitleView("h0_view0")
        let h0_view1 = TitleView("h0_view1")
        let h0_view2 = TitleView("h0_view2")
        let h1_view00 = TitleView("h1_view00")
        let h1_view01 = TitleView("h1_view01")
        let h1_view10 = TitleView("h1_view10")
        let h1_view11 = TitleView("h1_view11")
        let h2_view000 = TitleView("h2_view000")

        view.addSubview(h0_view0)
        view.addSubview(h0_view1)
        view.addSubview(h0_view2)

        h0_view0.addSubview(h1_view00)
        h0_view0.addSubview(h1_view01)

        h0_view1.addSubview(h1_view10)
        h0_view1.addSubview(h1_view11)

        h1_view00.addSubview(h2_view000)

        let allSubviews = view.allSubViews()
        XCTAssertEqual(allSubviews.count, 8)
    }

    func testParentViewController() {
        let view = TitleView("")

        let vc = UIViewController()
        let vc1 = ViewController1()

        var parentVC: UIViewController?
        var parentVC1: ViewController1?
        var parentVC2: ViewController2?

        parentVC = view.parentViewController()
        parentVC1 = view.parentViewController()
        parentVC2 = view.parentViewController()
        XCTAssertNil(parentVC)
        XCTAssertNil(parentVC1)
        XCTAssertNil(parentVC2)

        view.removeFromSuperview()
        vc.view.addSubview(view)
        parentVC = view.parentViewController()
        parentVC1 = view.parentViewController()
        parentVC2 = view.parentViewController()
        XCTAssertNotNil(parentVC)
        XCTAssertNil(parentVC1)
        XCTAssertNil(parentVC2)

        view.removeFromSuperview()
        vc1.view.addSubview(view)
        parentVC = view.parentViewController()
        parentVC1 = view.parentViewController()
        parentVC2 = view.parentViewController()
        XCTAssertNotNil(parentVC)
        XCTAssertNotNil(parentVC1)
        XCTAssertNil(parentVC2)
    }

    class ViewController1: UIViewController {

    }

    class ViewController2: UIViewController {

    }

    class TitleView: UIView {
        let title: String
        init(_ title: String) {
            self.title = title
            super.init(frame: CGRect.zero)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var description: String {
            return title
        }
    }

}
