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

    func testJustTest() {
        let model = AnnieModel(age: 12, name: "tcui")
        
        if let json = try? model.toJSON() {
            print("\(json)")
        }

        let b = Int.primes(first: 10)
        
        print("\(b)")
    }
    
    func testPing() {
        let model = AnnieModel(age: 12, name: "tcui")
        print("\(model.greeting())")
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
