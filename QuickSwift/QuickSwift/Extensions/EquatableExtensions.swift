//
//  EquatableExtensions.swift
//  QuickSwift
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol ObjectEquatable: class, Equatable {

}

public extension ObjectEquatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}
