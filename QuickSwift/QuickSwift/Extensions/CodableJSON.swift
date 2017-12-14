//
//  CodableJSON.swift
//  QuickSwift
//
//  Created by tcui on 14/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct CodableJSON {
    // MARK: - Codable
    public static func parse<T: Decodable>(fromData data: Data, settings: (JSONDecoder) -> Void = {_ in }) throws -> T {
        let jsonDecoder = JSONDecoder()
        settings(jsonDecoder)
        return try jsonDecoder.decode(T.self, from: data)
    }

    public static func parse<T: Decodable>(fromString string: String, settings: (JSONDecoder) -> Void = {_ in }) throws -> T {
        return try parse(fromData: string.toUtf8Data(), settings: settings)
    }

    public static func dump<T: Encodable>(toData any: T, settings: (JSONEncoder) -> Void = {_ in }) throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        settings(jsonEncoder)
        return try jsonEncoder.encode(any)
    }

    public static func dump<T: Encodable>(toString any: T, settings: (JSONEncoder) -> Void = {_ in }) throws -> String {
        let data = try dump(toData: any, settings: settings)
        return try data.toUtf8S()
    }
}

public extension Encodable {
    public func toJSON() throws -> String {
        return try CodableJSON.dump(toString: self)
    }

    public func toData() throws -> Data {
        return try CodableJSON.dump(toData: self)
    }
}

public extension Decodable {
    init(fromData data: Data) throws {
        self = try CodableJSON.parse(fromData: data)
    }

    init(fromString string: String) throws {
        self = try CodableJSON.parse(fromString: string)
    }
}

public protocol CustomCodable {
    static func encodeSettings() -> (JSONEncoder) -> Void
    static func decodeSettings() -> (JSONDecoder) -> Void
}

public extension Encodable where Self : CustomCodable {
    public func toJSON() throws -> String {
        return try CodableJSON.dump(toString: self, settings: Self.encodeSettings())
    }

    public func toData() throws -> Data {
        return try CodableJSON.dump(toData: self, settings: Self.encodeSettings())
    }
}

public extension Decodable where Self : CustomCodable {
    init(fromData data: Data) throws {
        self = try CodableJSON.parse(fromData: data, settings: Self.decodeSettings())
    }

    init(fromString string: String) throws {
        self = try CodableJSON.parse(fromString: string, settings: Self.decodeSettings())
    }
}
