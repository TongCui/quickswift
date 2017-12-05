//
//  ArrayExtensions.swift
//  ArrayExtensions
//
//  Created by tcui on 21/11/2017.
//

import Foundation

// MARK: - Math

public extension Array where Element : Numeric {
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

public extension Array where Element : FloatingPoint {
    public func average() -> Element {
        guard !isEmpty else { return 0 }
        let sum = self.sum()
        return sum / Element(count)
    }
}

// MARK: - Handle

public extension Array {

    public mutating func push(_ newElement: Element) {
        append(newElement)
    }

    @discardableResult public mutating func pop() -> Element? {
        return popLast()
    }

    public mutating func shift(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    @discardableResult public mutating func unshift() -> Element? {
        guard !isEmpty else {
            return nil
        }
        return removeFirst()
    }
}

// MARK: - Safe

public extension Array {

    public mutating func safeRemove(at index: Int) {
        guard startIndex..<endIndex ~= index else {
            return
        }
        remove(at: index)
    }

    public mutating func safeInsert(_ newElement: Element, at index: Int) {
        guard startIndex..<endIndex ~= index else {
            return
        }
        insert(newElement, at: index)
    }

    public mutating func safeSwapAt(_ fromIndex: Int, _ toIndex: Int) {
        guard startIndex..<endIndex ~= fromIndex, startIndex..<endIndex ~= toIndex else {
            return
        }
        swapAt(fromIndex, toIndex)
    }
}

// MARK: - Element

public extension Array where Element : Equatable {
    public mutating func removeElement(_ element: Element) {
        guard let idx = index(of: element) else {
            return
        }
        remove(at: idx)
    }

    public mutating func swapElements(_ fromElement: Element, _ toElement: Element) {
        guard let fromIndex = index(of: fromElement), let toIndex = index(of: toElement) else {
            return
        }
        swapAt(fromIndex, toIndex)
    }

    public mutating func removeElements(_ elements: [Element]) {
        self = reject { elements.contains($0) }
    }

    static func == (lhs: [[Element]], rhs: [[Element]]) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        return !zip(lhs, rhs).contains { $0.0 != $0.1 }
    }
}

// MARK: - Conditions

public extension Array {
    public func all(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !predicate($0) }
    }

    public func none(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try predicate($0) }
    }

    public func any(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try contains(where: predicate)
    }

    public func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { try !condition($0) }
    }
}

// MARK: - For Loop

public extension Array {
    public func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try body(element)
        }
    }

    //  (element, index)
    public func forEachWithIndex(_ body: (Int, Element) throws -> Void) rethrows {
        for (index, element) in self.enumerated() {
            try body(index, element)
        }
    }

    public func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach { try body($0) }
    }

    //  (element, index)
    public func forEachReversedWithIndex(_ body: (Int, Element) throws -> Void) rethrows {
        for (index, element) in self.enumerated().reversed() {
            try body(index, element)
        }
    }
}

// MARK: - Group

public extension Array {
    public func group(bySize size: Int) -> [[Element]] {
        guard size > 0, !isEmpty else {
            return []
        }

        var startIndex: Int = 0
        var slices: [[Element]] = []
        while startIndex < count {
            slices.append(Array(self[startIndex..<Swift.min(startIndex + size, endIndex)]))
            startIndex += size
        }
        return slices
    }

    public func group<K: Hashable>(byKey keyForValue: (_ element: Element) throws -> K) rethrows -> [K: [Element]] {
        var group = [K: [Element]]()
        for value in self {
            let key = try keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
}
