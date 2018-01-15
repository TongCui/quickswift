//
//  JSON.swift
//  QuickSwift
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public enum JSONError: Error, CustomStringConvertible {
    case invalidObject
    case invalidType(type: String)

    public var description: String {
        switch self {
        case .invalidObject: return "Failed: invalid json object"
        case .invalidType(let type): return "Failed: invalid type \(type)"
        }
    }
}

public struct JSON {

    public static func dump(toString object: Any, prettify: Bool = false) throws -> String {
        let data = try dump(toData: object, prettify: prettify)
        return try data.toUtf8S()
    }

    public static func dump(toData object: Any, prettify: Bool = false) throws -> Data {
        guard isValid(any: object) else {
            throw JSONError.invalidObject
        }

        let options: JSONSerialization.WritingOptions
        if #available(iOS 11.0, *) {
            options = (prettify == true) ? .prettyPrinted : .sortedKeys
        } else {
            options = .prettyPrinted
        }
        return try JSONSerialization.data(withJSONObject: object, options: options)
    }

    public static func parse<T>(fromString string: String) throws -> T {
        return try parse(fromData : string.toUtf8Data())
    }

    public static func parse<T>(fromData data: Data) throws -> T {
        let any = try JSONSerialization.jsonObject(with: data)
        guard let object = any as? T else {
            throw JSONError.invalidType(type: String(describing: T.self) )
        }
        return object
    }

    ///
    /// Dictionary [Key: Value], Key must be String
    ///
    public static func isValid(any: Any) -> Bool {
        return JSONSerialization.isValidJSONObject(any)
    }
}
