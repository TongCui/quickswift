//
//  ModelTestCases.swift
//  QuickSwiftTests
//
//  Created by tcui on 5/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class ModelTestCases: XCTestCase {

    func testPing() {
        let model = AnnieModel()
        let expect = expectation(description: "...")

        model.ping {
            print("Finish")
            expect.fulfill()
        }

        waitForExpectations(timeout: 40) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

}
