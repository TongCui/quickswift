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
    let stringValue : String = "str"
    let intValue : Int = 1
}

struct TestCodableModel: Codable {
    let stringValue : String = "str"
    let intValue : Int = 1
}

struct TestCustomCodableModel: Codable, CustomCodable {
    
    let dateValue : Date = Date(timeIntervalSince1970: 0)
    
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
    let stringValue : String = "str"
    let intValue : Int = 1
    
    enum CodingKeys: String, CodingKey {
        case stringValue = "str"
        case intValue = "int"
    }
}



struct TestComplexModel: Codable {
    let stringValue : String = "str"
    let intValue : Int = 1
    let floatValue : Float = 1.2
    let doubleValue : Double = 1.2
    let intArrayValue : [Int] = [1, 2]
    let stringArrayValue : [String] = ["1", "2"]
    let intDictionary : [Int : Int] = [1:1, 2:2]
    let strDictionary : [String : Int] = ["1":1, "2":2]
}


