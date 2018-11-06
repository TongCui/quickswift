//
//  FileManagerExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class FileManagerExtensionsTests: XCTestCase {

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

    func testDirectoryURL() {
        var url = FileManager.directoryURL(for: .documentDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Documents/$")

        url = FileManager.directoryURL(for: .cachesDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Library/Caches/$")
    }

    func testFileURL() {
        var fileName = "file"

        var url = FileManager.fileURL(fileName: fileName, in: .documentDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Documents/\(fileName)$")

        url = FileManager.fileURL(fileName: fileName, in: .cachesDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Library/Caches/\(fileName)$")

        fileName = "file.txt"

        url = FileManager.fileURL(fileName: fileName, in: .documentDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Documents/\(fileName)$")

        url = FileManager.fileURL(fileName: fileName, in: .cachesDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Library/Caches/\(fileName)$")

        fileName = "files/file.txt"

        url = FileManager.fileURL(fileName: fileName, in: .documentDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Documents/\(fileName)$")

        url = FileManager.fileURL(fileName: fileName, in: .cachesDirectory)
        XCTAssertTrue(url.absoluteString =~ "/Library/Caches/\(fileName)$")
    }

    func testFileExists() {
        let fileName = "file"
        XCTAssertFalse(FileManager.fileExists(fileName: fileName, in: .documentDirectory))
        try! FileManager.touch(fileName: fileName, in: .documentDirectory)
        XCTAssertTrue(FileManager.fileExists(fileName: fileName, in: .documentDirectory))
    }

    func testURLs() {
        try! FileManager.touch(fileName: "file", in: .documentDirectory)
        XCTAssertEqual(FileManager.files(in: .documentDirectory), ["file"])
    }

    func testTouch() {
        print("\(FileManager.directoryURL(for: .documentDirectory ))")
        XCTAssertEqual(FileManager.fileURLs(in: .documentDirectory).count, 0)
        try! FileManager.touch(fileName: "a.txt", in: .documentDirectory)
        XCTAssertEqual(FileManager.fileURLs(in: .documentDirectory).count, 1)

        XCTAssertEqual(FileManager.fileURLs(in: .cachesDirectory).count, 0)
        try! FileManager.touch(fileName: "files/a.txt", in: .cachesDirectory)
        XCTAssertEqual(FileManager.fileURLs(in: .cachesDirectory).count, 1)
    }

    func testClear() {
        XCTAssertEqual(FileManager.fileURLs(in: .documentDirectory).count, 0)
        1.upto(5) { idx in
            try! FileManager.touch(fileName: "\(idx).txt", in: .documentDirectory)
        }
        let files = FileManager.fileURLs(in: .documentDirectory).map { try! $0.path.fileName.toI() }.sorted()
        XCTAssertEqual(files, [1, 2, 3, 4, 5])
    }

    func testRemove() {
        let file = "a.txt"
        try! FileManager.touch(fileName: file, in: .documentDirectory)
        XCTAssertTrue(FileManager.fileExists(fileName: file, in: .documentDirectory))
        try! FileManager.remove(fileName: file, in: .documentDirectory)
        XCTAssertFalse(FileManager.fileExists(fileName: file, in: .documentDirectory))
    }

}
