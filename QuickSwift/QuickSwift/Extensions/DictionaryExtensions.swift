//
//  DictionaryExtensions.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func has(key: Key) -> Bool {
        return self.contains { $0.0 == key }
    }

    public mutating func removeAll(keys: [Key]) {
        keys.forEach { removeValue(forKey: $0) }
    }
}

public extension Dictionary where Value : Equatable {
    public func has(value: Value) -> Bool {
        return self.contains { $0.1 == value }
    }
}

public extension Dictionary where Value : Hashable {

    public func fliped() -> [Value: Key] {
        return reduce(into: [Value : Key]()) { (result, element) in
            result[element.value] = element.key
        }
    }
}

public extension Dictionary {

    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }

    public static func - (lhs: [Key: Value], keys: [Key]) -> [Key: Value] {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }

    public static func -= (lhs: inout [Key: Value], keys: [Key]) {
        lhs.removeAll(keys: keys)
    }

}
