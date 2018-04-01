//
//  TypeConvertions.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public enum TypeConvertError<From, To>: Error, CustomStringConvertible {
    case cannotConvert(From.Type, To.Type)

    public var description: String {
        switch self {
        case .cannotConvert(let from, let to):
            return "Failed: Cannot convert from \(from) to \(to)"
        }
    }
}

public extension CustomStringConvertible {
    public func toS() -> String { return description }
}

public extension Bool {
    public func toI() -> Int { return self ? 1 : 0 }
    public func toF() -> Float { return self ? 1 : 0 }
    public func toD() -> Double { return self ? 1 : 0 }
    public func toS() -> String { return self ? "true" : "false" }
}

public extension Int {
    public func toF() -> Float { return Float(self) }
    public func toCGF() -> CGFloat { return CGFloat(self) }
    public func toD() -> Double { return Double(self) }
    public func toB() -> Bool { return self == 1 ? true : false }
    public func toChr() throws -> Character {
        guard self > 0, let scalar = Unicode.Scalar(self), scalar.isASCII else {
            throw TypeConvertError.cannotConvert(Int.self, Character.self)
        }
        return Character(scalar)
    }
}

public extension Float {
    public func toI() -> Int { return Int(self) }
    public func toD() -> Double { return Double(self) }
    public func toCGF() -> CGFloat { return CGFloat(self) }
}

public extension Double {
    public func toI() -> Int { return Int(self) }
    public func toF() -> Float { return Float(self) }
    public func toCGF() -> CGFloat { return CGFloat(self) }
}

public extension String {
    public func toI() throws -> Int {
        guard let value = Int(self) else {
            throw TypeConvertError.cannotConvert(String.self, Int.self)
        }
        return value
    }

    public func toF() throws -> Float {
        guard let value = Float(self) else {
            throw TypeConvertError.cannotConvert(String.self, Float.self)
        }
        return value
    }

    public func toD() throws -> Double {
        guard let value = Double(self) else {
            throw TypeConvertError.cannotConvert(String.self, Double.self)
        }
        return value
    }

    public func toUtf8Data() -> Data { return data(using: .utf8)! }

    public func toJSONObject<T>() throws -> T {
        return try JSON.parse(fromString: self)
    }

    public func toArray<Value: Decodable>() throws -> [Value] {
        do {
            let valueArray: [Value] = try Array(fromJSONString: self)
            return valueArray
        } catch {
            throw TypeConvertError.cannotConvert(String.self, [Value].self)
        }
    }

    public func toDictionary<Value: Decodable>() throws -> [String: Value] {
        do {
            let valueDictionary: [String: Value] = try Dictionary(fromJSONString: self)
            return valueDictionary
        } catch {
            throw TypeConvertError.cannotConvert(String.self, [String: Value].self)
        }
    }

    public func toJSON<Value: Decodable>() throws -> [String: Value] {
        return try toDictionary()
    }
}

public extension Data {
    public func toJSONObject<T>() throws -> T {
        return try JSON.parse(fromData: self)
    }

    public func toArray<Value: Decodable>() throws -> [Value] {
        do {
            let valueArray: [Value] = try Array(fromData: self)
            return valueArray
        } catch {
            throw TypeConvertError.cannotConvert(Data.self, [Value].self)
        }
    }

    public func toDictionary<Value: Decodable>() throws -> [String: Value] {
        do {
            let valueDictionary: [String: Value] = try Dictionary(fromData: self)
            return valueDictionary
        } catch {
            throw TypeConvertError.cannotConvert(Data.self, [String: Value].self)
        }
    }

    public func toJSON<Value: Decodable>() throws -> [String: Value] {
        return try toDictionary()
    }

    public func toUtf8S() throws -> String {
        guard let value = String(data: self, encoding: .utf8) else {
            throw TypeConvertError.cannotConvert(Data.self, String.self)
        }
        return value
    }
}

public extension Character {
    public func toAscii() -> Int {
        let s = String(self).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}
