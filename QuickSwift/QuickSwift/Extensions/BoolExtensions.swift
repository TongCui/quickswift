//
//  BoolExtensions.swift
//  QuickSwift
//
//  Created by tcui on 8/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Bool {
    public var toggled: Bool { return !self }

    public mutating func toggle() {
        self = !self
    }
}
