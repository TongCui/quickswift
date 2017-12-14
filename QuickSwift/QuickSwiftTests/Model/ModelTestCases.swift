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

    func testAsWell() {
        let model = AnnieModel(age: 12, name: "tcui")

        print("\(FileManager.directoryURL(for: .documentDirectory))")
        print("\(FileManager.directoryURL(for: .cachesDirectory))")

        print("\(FileManager.fileURL(fileName: "book.txt", in: .documentDirectory))")

        do {
            try FileManager.save(model, intoFile: "book.txt", in: .documentDirectory)
            let model: AnnieModel = try FileManager.load(fromFile: "Books/book.txt", in: .documentDirectory)

            print("model is \(try model.toJSON())")
        } catch {

            print("error \(error)")
        }
    }

    func testAsWell1() {
        let model = AnnieModel(age: 12, name: "tcui")

        do {
            try model.save(to: "aa.txt")
            let newModel: AnnieModel = try AnnieModel(load:"aa.txt")

            print("newModel is \(try newModel.toJSON())")
        } catch {

            print("error \(error)")
        }
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
