//
//  DictionaryExtensions.swift
//  QuickSwift
//
//  Created by tcui on 6/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func has(key: Key) -> Bool {
        return self.contains { $0.0 == key }
    }
}

public extension Dictionary where Value : Equatable {
    public func has(value: Value) -> Bool {
        return self.contains { $0.1 == value }
    }
}

public extension Dictionary where Value : Hashable {

    public func fliped() -> [Value: Key] {
        return reduce(into: [Value : Key]()) { (result, element) in
            result[element.value] = element.key
        }
    }
}
