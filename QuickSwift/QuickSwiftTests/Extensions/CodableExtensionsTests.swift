//
//  CodableExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 9/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//
/*
import XCTest
@testable import QuickSwift

class CodableExtensionsTests: XCTestCase {

    func clear() {
        try? FileManager.clear(directory: .documentDirectory)
        try? FileManager.clear(directory: .cachesDirectory)
    }

    override func setUp() {
        super.setUp()
        clear()
    }

    override func tearDown() {
        clear()
        super.tearDown()
    }

    let file1 = FileManager.fileURL(fileName: "file1", in: .documentDirectory)
    let file2 = FileManager.fileURL(fileName: "file2", in: .documentDirectory)

    func testNormalModel() {
        let model: Model0 = Model0(age: 20, name: "username")
        let data = try! model.toData()
        let string = try! model.toJSONString()
        let json = try! model.toJSON()

        try! model.save(to: file1)
        try! model.save(to: file2) { data in
            data.simpleDecrypted(offset: 200)
        }

        XCTAssertNotNil(try? Model0(fromData: data))
        XCTAssertNotNil(try? Model0(fromJSONString: string))
        XCTAssertNotNil(try? Model0(fromJSON: json))
        XCTAssertNotNil(try? Model0(fromFile: file1))
        XCTAssertNotNil(try? Model0(fromFile: file2) { data in data.simpleDecrypted(offset: 200)})
    }

    func testCustomModel() {
        let model: Model3 = Model3(date: Date(timeIntervalSince1970: 0))
        let data = try! model.toData()
        let string = try! model.toJSONString()
        let json = try! model.toJSON()

        try! model.save(to: file1)
        try! model.save(to: file2) { data in
            data.simpleDecrypted(offset: 200)
        }

        XCTAssertNotNil(try? Model3(fromData: data))
        XCTAssertNotNil(try? Model3(fromJSONString: string))
        XCTAssertNotNil(try? Model3(fromJSON: json))
        XCTAssertNotNil(try? Model3(fromFile: file1))
        XCTAssertNotNil(try? Model3(fromFile: file2) { data in data.simpleDecrypted(offset: 200)})
    }
}
*/
