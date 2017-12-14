//
//  CodableJSONTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 14/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class CodableJSONTests: XCTestCase {

    func testDump() {
        XCTAssertEqual(try CodableJSON.dump(toString: [1, 2, 3]), "[1,2,3]")
        XCTAssertEqual(try CodableJSON.dump(toString: ["1", "2", "3"]), "[\"1\",\"2\",\"3\"]")
        XCTAssertEqual(try CodableJSON.dump(toString: [1:"100", 2:"200"]), "{\"1\":\"100\",\"2\":\"200\"}")
        XCTAssertEqual(try CodableJSON.dump(toString: ["1":"100", "2":"200"]), "{\"1\":\"100\",\"2\":\"200\"}")
    }
    
    func testParse() {
        XCTAssertEqual(try CodableJSON.parse(fromString: "[1,2,3]"), [1, 2, 3])
        XCTAssertEqual(try CodableJSON.parse(fromString: "[\"1\",\"2\",\"3\"]"), ["1", "2", "3"])
        XCTAssertEqual(try CodableJSON.parse(fromString: "{\"1\":\"100\",\"2\":\"200\"}"), [1:"100", 2:"200"])
        XCTAssertEqual(try CodableJSON.parse(fromString: "{\"1\":\"100\",\"2\":\"200\"}"), ["1":"100", "2":"200"])
    }

    
    func testCodableModel() {
        let testModel = TestCodableModel()
        
        do {
            let jsonString = try CodableJSON.dump(toString: testModel)
            print("\(jsonString)")
            
            let newModel: TestCodableModel = try CodableJSON.parse(fromString: jsonString)
            
            print("\(newModel)")
            
            
        } catch {
            
        }
        
    }
}
