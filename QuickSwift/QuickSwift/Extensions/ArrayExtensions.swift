//
//  ArrayExtensions.swift
//  ArrayExtensions
//
//  Created by tcui on 21/11/2017.
//

import Foundation

// MARK: - Math

public extension Array where Element: FloatingPoint {
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

public extension Array where Element: Equatable {
    public mutating func removeElement(_ element: Element) {
        self = filter { $0 != element }
    }

    public mutating func removeElements(_ items: [Element]) {
        guard !items.isEmpty else { return }
        self = filter { !items.contains($0) }
    }

    public mutating func unique() {
        self = uniqued()
    }

    public func uniqued() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    public mutating func shuffle() {
        guard count > 1 else { return }
        for index in startIndex..<endIndex - 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
            if index != randomIndex { swapAt(index, randomIndex) }
        }
    }

    public func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }

    public mutating func swapElements(_ fromElement: Element, _ toElement: Element) {
        guard let fromIndex = index(of: fromElement), let toIndex = index(of: toElement) else {
            return
        }
        swapAt(fromIndex, toIndex)
    }

    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        return elements.all { contains($0) }
    }

    public func indexes(of item: Element) -> [Int] {
        var indexs = [Int]()
        for index in startIndex..<endIndex where self[index] == item {
            indexs.append(index)
        }
        return indexs
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
