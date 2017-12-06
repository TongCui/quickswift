//
//  TypeConvertions.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

protocol PrimaryTypeConvertible {
    var toI: Int { get }
    var toF: Float { get }
    var toD: Double { get }
    var toS: String { get }
}

protocol PrimaryTypeOptionalConvertible {
    var toI: Int? { get }
    var toF: Float? { get }
    var toD: Double? { get }
    var toS: String? { get }
}

extension Int: PrimaryTypeConvertible {
    var toI: Int { return self }
    var toF: Float { return Float(self) }
    var toD: Double { return Double(self) }
    var toS: String { return String(self) }
}

extension Float: PrimaryTypeConvertible {
    var toI: Int { return Int(self) }
    var toF: Float { return self }
    var toD: Double { return Double(self) }
    var toS: String { return String(self) }
}

extension Double: PrimaryTypeConvertible {
    var toI: Int { return Int(self) }
    var toF: Float { return Float(self) }
    var toD: Double { return self }
    var toS: String { return String(self) }
}

extension String: PrimaryTypeOptionalConvertible {
    var toI: Int? { return Int(self) }
    var toF: Float? { return Float(self) }
    var toD: Double? { return Double(self) }
    var toS: String? { return self }
}
