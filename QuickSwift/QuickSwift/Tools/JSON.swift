//
//  JSON.swift
//  QuickSwift
//
//  Created by tcui on 7/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol JSONStringConvertible {
    init?(jsonString: String)
    var toJSON: String? { get }
    func jsonString(prettify: Bool) -> String?
}

public extension JSONStringConvertible {
    public var toJSON: String? { return jsonString(prettify: false) }
    public func jsonString(prettify: Bool) -> String? {
        return JSON.dump(any: self, prettify: prettify)
    }
}

public struct JSON {
    public static func parseDictionary<Value>(fromData data: Data) -> [String: Value]? {
        guard let json = try? JSONSerialization.jsonObject(with: data) else {
            return nil
        }

        return json as? [String: Value]
    }

    public static func parseDictionary<Value>(fromString jsonString: String) -> [String: Value]? {
        guard let data = jsonString.toData else {
            return nil
        }
        return parseDictionary(fromData: data)
    }

    public static func parseArray<Value>(fromData data: Data) -> [Value]? {
        guard let json = try? JSONSerialization.jsonObject(with: data) else {
            return nil
        }

        return json as? [Value]
    }

    public static func parseArray<Value>(fromString jsonString: String) -> [Value]? {
        guard let data = jsonString.toData else {
            return nil
        }
        return parseArray(fromData: data)
    }

    public static func dump(any: Any, prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(any) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions.sortedKeys
        guard let jsonData = try? JSONSerialization.data(withJSONObject: any, options: options) else {
            return nil
        }
        return jsonData.toS
    }
}

extension Array: JSONStringConvertible {
    public init?(jsonString: String) {
        guard let array: [Element] = JSON.parseArray(fromString: jsonString) else {
            return nil
        }
        self = array
    }
}

extension Dictionary: JSONStringConvertible {
    public init?(jsonString: String) {
        return nil
    }
}

public extension Dictionary where Key == String {
    public init?(jsonString: String) {
        guard let dictionary: [String: Value] = JSON.parseDictionary(fromString: jsonString) else {
            return nil
        }
        self = dictionary
    }
}
