//
//  MultiSetTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest
@testable import QuickSwift

struct BagElement: Hashable {
    var name: String
    var hashValue: Int { return name.hashValue }
    
    static func ==(lhs: BagElement, rhs: BagElement) -> Bool {
        return lhs.name == rhs.name
    }
}

class MultiSetTests: XCTestCase {
    
    var bag: MultiSet<String> = {
        var multiSet: MultiSet<String> = []
        multiSet.add("book")
        multiSet.add("book")
        multiSet.add("book")
        multiSet.add("water")
        multiSet.add("note")
        return multiSet
    }()
    
    func testCount() {
        XCTAssertEqual(bag.uniqueCount, 3)
        XCTAssertEqual(bag.totalCount, 5)
    }
    
    func testElements() {
        XCTAssertEqual(bag.elements.sorted(), ["book", "note", "water"])
    }
    
    func testAddRemove() {
        XCTAssertEqual(bag.totalCount, 5)
        XCTAssertEqual(bag["book"], 3)
        bag.add("book")
        XCTAssertEqual(bag["book"], 4)
        bag.remove("book")
        XCTAssertEqual(bag["book"], 3)
        bag.remove("note")
        XCTAssertEqual(bag.uniqueCount, 2)
    }
    
    func testDescription() {
        print(bag)
        debugPrint(bag)
        XCTAssertEqual(bag.description, "[\"note\": 1, \"water\": 1, \"book\": 3]")
        XCTAssertEqual(bag.debugDescription, "[\"note\": 1, \"water\": 1, \"book\": 3]")
    }
    
    func testEqual() {
        var anotherBag = bag
        anotherBag.add("note")
        print(anotherBag)
        XCTAssertFalse(bag == anotherBag)
        anotherBag.remove("note")
        XCTAssertTrue(bag == anotherBag)
        
        bag = ["book":1, "water":2, "note":1]
        anotherBag = ["book":1, "water":2]
        XCTAssertFalse(bag == anotherBag)
    }
    
    func testSubscript() {
        bag["book"] = 10
        bag["water"] = 10
        bag["note"] = 10
        XCTAssertEqual(bag.totalCount, 30)
        bag["note"] = 0
        XCTAssertEqual(bag.totalCount, 20)
        XCTAssertEqual(bag.uniqueCount, 2)
        XCTAssertEqual(bag["nothing"], 0)
    }
    
    func testCollections() {
        XCTAssertFalse(bag.isEmpty)
        let filtered = bag.filter { (key, value) in
            key == "note"
        }
        
        XCTAssertEqual(filtered.count, 1)
    }
    
    func testHashableElement() {
        var elementBag: MultiSet<BagElement> = []
        elementBag.add(BagElement(name: "book"))
        elementBag.add(BagElement(name: "book"))
        elementBag.add(BagElement(name: "note"))
        XCTAssertEqual(elementBag.uniqueCount, 2)
        XCTAssertEqual(elementBag.totalCount, 3)
        elementBag[BagElement(name: "book")] = 0
        XCTAssertEqual(elementBag.uniqueCount, 1)
        XCTAssertEqual(elementBag.totalCount, 1)
    }
    
    func testArrayLiteral() {
        bag = ["book", "book", "water", "note"]
        XCTAssertEqual(bag["book"], 2)
        XCTAssertEqual(bag["water"], 1)
        XCTAssertEqual(bag["note"], 1)
    }
    
    func testDictionaryLiteral() {
        bag = ["book": 3, "water":10]
        XCTAssertEqual(bag["book"], 3)
        XCTAssertEqual(bag["water"], 10)
    }
    
}
