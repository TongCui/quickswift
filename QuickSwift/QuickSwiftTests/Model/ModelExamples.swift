//
//  ModelExamples.swift
//  QuickSwiftTests
//
//  Created by tcui on 2/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation
@testable import QuickSwift

protocol ModelDescriptionExpressible {
    static func modelDescription() -> String
}

struct Model0: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struct with int and string properties"
    }

    var age: Int
    var name: String
}

class Model1: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Class with int and string properties"
    }

    init() {

    }

    var age: Int = 0
    var name: String = ""
}

struct Model2: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struc with date property, default date format"
    }

    var date: Date
}

struct Model3: ModelDescriptionExpressible, Codable, CustomCodable {
    static func modelDescription() -> String {
        return "Struc with date property, '.secondsSince1970' date format"
    }

    static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.dateDecodingStrategy = .secondsSince1970
        }
    }

    static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.dateEncodingStrategy = .secondsSince1970
        }
    }

    var date: Date
}

struct Model4: ModelDescriptionExpressible, Codable, CustomCodable {

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static func modelDescription() -> String {
        return "Struc with date property, 'yyyy-MM-dd' date format"
    }

    static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.dateDecodingStrategy = .formatted(formatter)
        }
    }

    static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.dateEncodingStrategy = .formatted(formatter)
        }
    }

    var date: Date
}

struct Model5: ModelDescriptionExpressible, Codable {

    static func modelDescription() -> String {
        return "Struct with double and string array properties"
    }

    var weights: [Float]
    var names: [String]
}

class Model6: ModelDescriptionExpressible, Codable, CustomCodable {
    class func modelDescription() -> String {
        return "Class with int and date array properties"
    }

    static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.dateDecodingStrategy = .iso8601
        }
    }

    static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.dateEncodingStrategy = .iso8601
        }
    }

    init() {

    }

    var counts: [Int] = []
    var birthdays: [Date] = []
}

struct Model7: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struct with optional Int property"
    }

    var age: Int?
}

struct Model8: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struct with customizing key names"
    }

    var defaultName: String
    var customName: String

    enum CodingKeys: String, CodingKey {
        case defaultName
        case customName = "custom_name"
    }
}

struct Model9: ModelDescriptionExpressible, Codable, CustomCodable {
    static func modelDescription() -> String {
        return "Struct with custom float handler"
    }

    static func decodeSettings() -> (JSONDecoder) -> Void {
        return { decoder in
            decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+inf", negativeInfinity: "-inf", nan: "nan")
        }
    }

    static func encodeSettings() -> (JSONEncoder) -> Void {
        return { encoder in
            encoder.nonConformingFloatEncodingStrategy =
                .convertToString(positiveInfinity: "+inf", negativeInfinity: "-inf", nan: "nan")
        }
    }

    var value: Float
}

class Model10: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Class with url and url string properties"
    }

    init() {

    }

    var urlString: String?
    var url: URL?
}

class Model11: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Class with flatterning properties"
    }

    init() {

    }

    var name: String = ""
    var age: Int = 0
    var value: Int = 0

    enum CodingKeys: String, CodingKey {
        case name
        case info
    }

    enum InfoCodingKeys: String, CodingKey {
        case age
        case value
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)

        var info = container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)

        try info.encode(age, forKey: .age)
        try info.encode(value, forKey: .value)

    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)

        let info = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info
        )

        age = try info.decode(Int.self, forKey: .age)
        value = try info.decode(Int.self, forKey: .value)
    }
}

struct Model12: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struct with flatterning optional properties"
    }

    init() {

    }

    var name: String?
    var age: Int?
    var value: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case info
    }

    enum InfoCodingKeys: String, CodingKey {
        case age
        case value
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if let name = self.name {
            try container.encode(name, forKey: .name)
        }

        if !age.isNil || !value.isNil {
            var info = container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)

            if let age = self.age {
                try info.encode(age, forKey: .age)
            }

            if let value = self.value {
                try info.encode(value, forKey: .value)
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)

        if let info = try? container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info
            ) {
            age = try? info.decode(Int.self, forKey: .age)
            value = try? info.decode(Int.self, forKey: .value)
        }
    }
}

class Model13: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Nested classes"
    }

    init() {

    }

    var name: String?
    var model: Model0?
}

class Model14: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Nested classes - array"
    }

    init() {

    }

    var models: [Model0] = []
}

class Model15: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Nested classes - dictionary"
    }

    init() {

    }

    var models: [String: Model0] = [:]
}

struct Model16: ModelDescriptionExpressible, Codable {
    static func modelDescription() -> String {
        return "Struct with computed properties"
    }

    var value: Int

    var title: String {
        get {
            return "\(value)"
        }
        set {
            do {
                value = try newValue.toI()
            } catch {
                value = 0
            }
        }
    }
}

class Model17: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Class with 2-level nested properties"
    }

    init() {
        model = Model13()
    }

    var model: Model13
}

class Model18: ModelDescriptionExpressible, Codable {
    class func modelDescription() -> String {
        return "Class with non-json property"
    }

    init() {
    }

    var age: Int = 0
    var fakeAge: Int = 0

    enum CodingKeys: String, CodingKey {
        case age
    }
}
