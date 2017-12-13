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
}

public extension Int {
    public func toF() -> Float { return Float(self) }
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
}

public extension Double {
    public func toI() -> Int { return Int(self) }
    public func toF() -> Float { return Float(self) }
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
    
    public func toArray<Value>() throws -> [Value] {
        do {
            return try JSON.parse(fromString: self)
        } catch {
            throw TypeConvertError.cannotConvert(String.self, [Value].self)
        }
    }
    
    public func toDictionary<Key, Value>() throws -> [Key: Value] {
        do {
            return try JSON.parse(fromString: self)
        } catch {
            throw TypeConvertError.cannotConvert(String.self, [Key: Value].self)
        }
    }
}

public extension Data {
    public func toArray<Value>() throws -> [Value] {
        do {
            return try JSON.parse(fromData: self)
        } catch {
            throw TypeConvertError.cannotConvert(Data.self, [Value].self)
        }
    }
    
    public func toDictionary<Key, Value>() throws -> [Key: Value] {
        do {
            return try JSON.parse(fromData: self)
        } catch {
            throw TypeConvertError.cannotConvert(Data.self, [Key: Value].self)
        }
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

public extension Encodable {
    public func toJSON() throws -> String {
        return try JSON.dump(toString: self)
    }
    
    public func toData() throws -> Data {
        return try JSON.dump(toData: self)
    }
}

public extension Decodable {
    init(fromData data: Data) throws {
        self = try JSON.parse(fromData: data)
    }

    init(fromString string: String) throws {
        self = try JSON.parse(fromString: string)
    }
}

public protocol CustomCodable {
    static func encodeSettings() -> (JSONEncoder) -> Void
    static func decodeSettings() -> (JSONDecoder) -> Void
}

public extension Encodable where Self : CustomCodable {
    public func toJSON() throws -> String {
        return try JSON.dump(toString: self, settings: Self.encodeSettings())
    }
    
    public func toData() throws -> Data {
        return try JSON.dump(toData: self, settings: Self.encodeSettings())
    }
}

public extension Decodable where Self : CustomCodable {
    init(fromData data: Data) throws {
        self = try JSON.parse(fromData: data, settings: Self.decodeSettings())
    }
    
    init(fromString string: String) throws {
        self = try JSON.parse(fromString: string, settings: Self.decodeSettings())
    }
}

