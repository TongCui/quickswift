//
//  FileTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class FileTests: XCTestCase {

    override func setUp() {
        super.setUp()
        clean()
    }

    override func tearDown() {
        clean()
        super.tearDown()
    }

    func clean() {
        try? FileManager.remove(fileName: "file.txt", in: .documentDirectory)
    }

    func testNonExistFile() {
        let file = File(name: "no_such_file.txt", bundle: TestBundle.bundle)
        XCTAssertNil(file)
    }

    func testBundleValidFile() {
        let bundleValidFile = File(name: "file.txt", bundle: TestBundle.bundle)

        XCTAssertNotNil(bundleValidFile)
        XCTAssertNotNil(bundleValidFile?.content)
        XCTAssertEqual(bundleValidFile?.lines.count, 5)
        XCTAssertEqual(bundleValidFile?.lines.first, "This is a test file")
    }

    func testBundleInvalidFile() {
        let bundleInvalidFile = File(name: "plist.plist", bundle: TestBundle.bundle)

        XCTAssertNotNil(bundleInvalidFile)
        XCTAssertTrue(bundleInvalidFile!.content.isEmpty)
    }

    func testDocumentFile() {
        let documentFile = File(name: "file.txt", in: .documentDirectory)

        XCTAssertNotNil(documentFile)
        XCTAssertTrue(FileManager.fileExists(fileName: "file.txt", in: .documentDirectory))
        XCTAssertEqual(documentFile.content, "")
        try! documentFile.write(string: "hello")
        XCTAssertEqual(documentFile.content, "hello")
    }

}
