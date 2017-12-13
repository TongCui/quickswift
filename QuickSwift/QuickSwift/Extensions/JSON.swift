//
//  JSON.swift
//  QuickSwift
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct JSON {

    public static func parse<T: Decodable>(fromData data: Data, settings: (JSONDecoder) -> Void = {_ in } ) throws -> T {
        let jsonDecoder = JSONDecoder()
        settings(jsonDecoder)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    public static func parse<T: Decodable>(fromString string: String,  settings: (JSONDecoder) -> Void = {_ in } ) throws -> T {
        return try parse(fromData: string.toUtf8Data(), settings: settings)
    }

    public static func dump<T: Encodable>(toData any: T, settings: (JSONEncoder) -> Void = {_ in } ) throws -> Data {
        let jsonEncoder = JSONEncoder()
        settings(jsonEncoder)
        return try jsonEncoder.encode(any)
    }
    
    public static func dump<T: Encodable>(toString any: T, settings: (JSONEncoder) -> Void = {_ in } ) throws -> String {
        let data = try dump(toData: any, settings: settings)
        return try data.toUtf8S()
    }
    
    public static func isValid(any: Any) -> Bool {
        return JSONSerialization.isValidJSONObject(any)
    }
}

