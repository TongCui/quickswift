//
//  StringExtensionsTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

class StringExtensionsTests: XCTestCase {

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

    func testFileName() {
        var file = "image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "./book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = ".//book/image.png"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertEqual(file.fileExtension, "png")

        file = "image.tmp.png"
        XCTAssertEqual(file.fileName, "image.tmp")
        XCTAssertEqual(file.fileExtension, "png")

        file = "image"
        XCTAssertEqual(file.fileName, "image")
        XCTAssertNil(file.fileExtension)
    }

    func testTrim() {
        var string = ""

        string = "tcui"
        XCTAssertEqual(string.trim(), "tcui")

        string = "  tcui"
        XCTAssertEqual(string.trim(), "tcui")

        string = "  tcui  "
        XCTAssertEqual(string.trim(), "tcui")

        string = "  tcui  \n\n"
        XCTAssertEqual(string.trim(), "tcui")

        string = "\n\n  tcui  \n\n"
        XCTAssertEqual(string.trim(), "tcui")

        string = "\n\n  t c ui  \n\n"
        XCTAssertEqual(string.trim(), "t c ui")
    }

    func testLanguage() {
        var string = ""
        string = "Today is Monday."
        XCTAssertEqual("en", string.language)

        string = "今天是星期一"
        XCTAssertEqual("zh-Hant", string.language)

        string = "今日は月曜日です"
        XCTAssertEqual("ja", string.language)
    }

    func testFileContentFromBundleFile() {
        var content: String?

        content = String(file: "no_such_file.txt", bundle: Bundle.test)
        XCTAssertNil(content)

        content = String(file: "file.txt", bundle: Bundle.test)
        XCTAssertNotNil(content)
        let expected = """
        This is a test file
        line2
        line3
        line4

        """

        XCTAssertEqual(expected, content!)
    }

    func testFileContentFromDocumentFile() {
        let fileName = "file.txt"
        let expected = """
        This is a test file
        line2
        line3
        line4

        """
        XCTAssertFalse(FileManager.fileExists(fileName: fileName, in: .documentDirectory))
        try? expected.write(file: "file.txt", in: .documentDirectory)

        XCTAssertTrue(FileManager.fileExists(fileName: fileName, in: .documentDirectory))

        XCTAssertEqual(expected, String(file: fileName, in: .documentDirectory)!)
    }

    func testFileLinesFromBundleFile() {
        var lines = [String]()

        lines.readLines(file: "no_such_file.txt", bundle: Bundle.test)
        XCTAssertTrue(lines.isEmpty)
        lines.readLines(file: "file.txt", bundle: Bundle.test)
        XCTAssertEqual(5, lines.count)
        XCTAssertEqual("This is a test file", lines.first!)
    }

    func testFileLinesFromDocumentFile() {
        let fileName = "file.txt"
        var lines = ["line1", "line2", "line3", "line4"]

        XCTAssertFalse(FileManager.fileExists(fileName: fileName, in: .documentDirectory))
        try? lines.write(file: "file.txt", in: .documentDirectory)
        XCTAssertTrue(FileManager.fileExists(fileName: fileName, in: .documentDirectory))
        let expected = lines
        lines.removeAll()
        lines.readLines(file: fileName, in: .documentDirectory)
        XCTAssertEqual(expected, lines)
    }

    func testRepeat() {
        let str = "str"

        //  str.repeat(0) # fatal error
        XCTAssertEqual("", str.repeat(0))
        XCTAssertEqual("str", str.repeat(1))
        XCTAssertEqual("strstrstr", str.repeat(3))
        XCTAssertEqual("strstrstrstr", str.repeat(4))
    }
}
