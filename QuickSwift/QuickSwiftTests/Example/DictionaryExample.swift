//
//  DictionaryExample.swift
//  QuickSwiftTests
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest

class DictionaryExample: XCTestCase {

    func testDictionaryInit() {
        let emptyDict: [String: String] = [:]
        print("\(emptyDict)")
    }

    func testDictionaryIterating() {
        let dict = [
            1:"100",
            2:"200"
        ]
        for (key, value) in dict {
            print("# \(key) ) \(value)")
        }
    }

}
