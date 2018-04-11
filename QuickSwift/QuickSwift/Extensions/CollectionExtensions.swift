//
//  CollectionExtensions.swift
//  QuickSwift
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Index == Int {
    public var randomItem: Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}

// MARK: - Math

public extension Collection where Element: Numeric {
    public func sum() -> Element {
        return self.reduce(0, +)
    }

    public func product() -> Element {
        guard !isEmpty else {
            return 0
        }
        return self.reduce(1, *)
    }
}
