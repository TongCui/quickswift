//
//  MultiSet.swift
//  QuickSwift
//
//  Created by tcui on 25/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct MultiSet<T: Hashable> {
    public typealias MultiSetType = [T: Int]
    private var contents: MultiSetType = [:]

    var elements: [T] {
        return contents.map { $0.key }
    }

    public init(contents: MultiSetType) {
        self.contents = contents
    }

    public init<C: Collection>(_ elements: C) where C.Element == T {
        elements.forEach { add($0) }
    }

    public var uniqueCount: Int {
        return contents.count
    }

    public var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }

    public mutating func add(_ element: T) {
        contents[element, default: 0] += 1
    }

    public mutating func remove(_ element: T) {
        if let currentCount = contents[element] {
            if currentCount > 1 {
                contents[element] = currentCount - 1
            } else {
                contents.removeValue(forKey: element)
            }
        }
    }
}

extension MultiSet: CustomDebugStringConvertible {
    public var debugDescription: String {
        return contents.debugDescription
    }
}

extension MultiSet: CustomStringConvertible {
    public var description: String {
        return contents.description
    }
}

extension MultiSet: Equatable {
    public static func == (lhs: MultiSet<T>, rhs: MultiSet<T>) -> Bool {
        if lhs.elements != rhs.elements {
            return false
        }
        for (lkey, lcount) in lhs.contents {
            let rcount = rhs.contents[lkey]!
            if lcount != rcount {
                return false
            }
        }
        return true
    }
}

extension MultiSet: Collection {
    public typealias Index = MultiSetType.Index
    public typealias Element = MultiSetType.Element

    public var startIndex: Index { return contents.startIndex }
    public var endIndex: Index { return contents.endIndex }

    public subscript(index: Index) -> Iterator.Element {
        get { return contents[index] }
    }

    public func index(after i: Index) -> Index {
        return contents.index(after: i)
    }

    public subscript(element: T) -> Int {
        get {
            return contents[element] ?? 0
        }
        set(newCount) {
            if newCount > 0 {
                contents[element] = newCount
            } else {
                contents.removeValue(forKey: element)
            }
        }
    }
}

extension MultiSet: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}

extension MultiSet: ExpressibleByDictionaryLiteral {
    public typealias Key = T
    public typealias Value = Int

    public init(dictionaryLiteral elements: (T, Int)...) {
        let contents = elements.reduce(into: [T: Int]()) { (result, element) in
            let (key, value) = element
            if value > 0 {
                result[key] = value
            }
        }

        self.init(contents: contents)
    }
}
