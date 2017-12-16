//
//  TestModel.swift
//  QuickSwiftTests
//
//  Created by tcui on 14/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation
@testable import QuickSwift

struct TestModel {
    let stringValue: String
    let intValue: Int

    init() {
        stringValue = "str"
        intValue = 1
    }
}

struct TestCodableModel: Codable, FilePersistence {
    let stringValue: String
    let intValue: Int

    init() {
        stringValue = "str"
        intValue = 1
    }
}

struct TestDateModel: Codable {
    let dateValue: Date

    init() {
        dateValue = Date(timeIntervalSince1970: 0)
    }
}

struct TestCustomCodableModel: Codable, CustomCodable {

    let dateValue: Date

    init() {
        dateValue = Date(timeIntervalSince1970: 0)
    }

    public static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.dateDecodingStrategy = .secondsSince1970
        }
    }

    public static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .secondsSince1970
        }
    }
}

struct TestCodingKeysModel: Codable {
    let stringValue: String
    let intValue: Int

    enum CodingKeys: String, CodingKey {
        case stringValue = "str"
        case intValue = "int"
    }

    init() {
        stringValue = "str"
        intValue = 1
    }
}

struct TestComplexModel: Codable {
    let stringValue: String
    let intValue: Int
    let doubleValue: Double
    let intArrayValue: [Int]
    let stringArrayValue: [String]
    let intDictionary: [Int: Int]
    let strDictionary: [String: Int]

    init() {
        stringValue = "str"
        intValue = 1
        doubleValue = 1.2
        intArrayValue = [1, 2]
        stringArrayValue = ["1", "2"]
        intDictionary = [1:1, 2:2]
        strDictionary = ["1":1, "2":2]
    }
}
