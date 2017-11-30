//
//  ArrayExtensionsTests.swift
//  QuickSwift_Tests
//
//  Created by tcui on 24/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class ArrayExtensionsTests: XCTestCase {
    
    
    func testSum() {
        let array = [1,2,3,4,5]
        XCTAssertEqual(array.sum(), 15)
    }
    
    func testSumEmpty() {
        let array = [Int]()
        XCTAssertEqual(array.sum(), 0)
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
