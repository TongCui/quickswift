//
//  CodableExtensions.swift
//  QuickSwift
//
//  Created by tcui on 14/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Encodable {

    public func toData() throws -> Data {
        let jsonEncoder = JSONEncoder()

        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = .sortedKeys
        }

        if let customCodable = type(of: self) as? CustomCodable.Type {
            customCodable.encodeSettings()(jsonEncoder)
        }

        return try jsonEncoder.encode(self)
    }

    public func toJSONString() throws -> String {
        return try toData().toUtf8S()
    }

    public func toJSON() throws -> [String: Any] {
        return try JSON.parse(fromData: try toData())
    }

    public func save(to file: URL, handler: ((Data) -> Data)? = nil) throws {
        var data = try toData()
        if let handler = handler {
           data = handler(data)
        }
        try data.write(to: file)
    }

}

public extension Decodable {
    init(fromData data: Data) throws {
        let jsonDecoder = JSONDecoder()
        if let customCodable = Self.self as? CustomCodable.Type {
            customCodable.decodeSettings()(jsonDecoder)
        }

        self = try jsonDecoder.decode(Self.self, from: data)
    }

    init(fromJSONString string: String) throws {
        try self.init(fromData: string.toUtf8Data())
    }

    init(fromJSON json: [String: Any]) throws {
        let data = try JSON.dump(toData: json)
        try self.init(fromData: data)
    }

    init(fromFile file: URL, handler: ((Data) -> Data)? = nil) throws {
        var data = try Data(contentsOf: file)
        if let handler = handler {
            data = handler(data)
        }
        try self.init(fromData: data)
    }
}

public protocol CustomCodable {
    static func encodeSettings() -> (JSONEncoder) -> Void
    static func decodeSettings() -> (JSONDecoder) -> Void
}
