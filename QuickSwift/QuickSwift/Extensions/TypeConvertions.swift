//
//  TypeConvertions.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

extension Bool {
    var toI: Int { return self ? 1 : 0 }
    var toF: Float { return self ? 1 : 0 }
    var toD: Double { return self ? 1 : 0 }
    var toS: String { return description }
}

extension Int {
    var toI: Int { return self }
    var toF: Float { return Float(self) }
    var toD: Double { return Double(self) }
    var toS: String { return String(self) }
}

extension Float {
    var toI: Int { return Int(self) }
    var toF: Float { return self }
    var toD: Double { return Double(self) }
    var toS: String { return String(self) }
}

extension Double {
    var toI: Int { return Int(self) }
    var toF: Float { return Float(self) }
    var toD: Double { return self }
    var toS: String { return String(self) }
}

extension String {
    var toI: Int? { return Int(self) }
    var toF: Float? { return Float(self) }
    var toD: Double? { return Double(self) }
    var toS: String? { return self }
    var toData: Data { return data(using: .utf8)! }
}

extension Data {
    var toS: String? { return String(data: self, encoding: .utf8) }
}
