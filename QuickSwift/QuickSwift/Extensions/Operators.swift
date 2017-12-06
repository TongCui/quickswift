//
//  Operators.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence

public func ** (lhs: Int, rhs: Int) -> Int {
    return Int(pow(Double(lhs), Double(rhs)))
}

public func ** (lhs: Float, rhs: Float) -> Float {
    return pow(lhs, rhs)
}

public func ** (lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
