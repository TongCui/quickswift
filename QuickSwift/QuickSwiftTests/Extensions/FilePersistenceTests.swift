//
//  FilePersistenceTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class FilePersistenceTests: XCTestCase {

    var fileModel = TestCodableModel()
    var uniqeFileModel = TestCodingKeysModel()

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

    func testFilePersistence() {
        fileModel.intValue = 100

        try! fileModel.save(to: "aaa.txt", in: .documentDirectory)
        XCTAssertTrue(FileManager.fileExists(fileName: "aaa.txt", in: .documentDirectory))

        try! fileModel.save(to: "bbb.txt", in: .cachesDirectory)
        XCTAssertTrue(FileManager.fileExists(fileName: "bbb.txt", in: .cachesDirectory))

        var model = try! TestCodableModel.load(from: "aaa.txt", in: .documentDirectory)
        XCTAssertEqual(model.intValue, 100)

        model = try! TestCodableModel.load(from: "bbb.txt", in: .cachesDirectory)
        XCTAssertEqual(model.intValue, 100)
    }

    func testUniqueFilePersistence() {
        let fileName = "model.txt"
        XCTAssertEqual(TestCodingKeysModel.fileName, fileName)

        uniqeFileModel.intValue = 100

        try! uniqeFileModel.save()
        XCTAssertTrue(FileManager.fileExists(fileName: fileName, in: .documentDirectory))

        let model = try! TestCodingKeysModel.load()
        XCTAssertEqual(model.intValue, 100)

    }
}
