//
//  TableDataSourceCollection.swift
//  QuickSwift
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol TableDataSourceCollection: Collection, ExpressibleByArrayLiteral {
    associatedtype TableElement
    var elements: [TableElement] { get set }
    init()
    init(elements: [TableElement])
}

// MARK: - Operations
public extension TableDataSourceCollection {
    init(elements: [TableElement]) {
        self.init()
        self.elements = elements
    }

    public mutating func append(_ element: TableElement) {
        elements.append(element)
    }

    public mutating func append(contentsOf contents: [TableElement]) {
        elements.append(contentsOf: contents)
    }

    public mutating func safeRemove(at index: Int) {
        elements.safeRemove(at: index)
    }

    public mutating func removeAll() {
        elements.removeAll()
    }

    public mutating func removeLast() {
        elements.removeLast()
    }

    public mutating func safeInsert(_ element: Element, at index: Int) {
        elements.safeInsert(element, at: index)
    }
}

// MARK: - Collection
public extension TableDataSourceCollection {
    public typealias Index = Int
    public typealias Element = TableElement

    public var startIndex: Index { return elements.startIndex }
    public var endIndex: Index { return elements.endIndex }

    public func index(after i: Int) -> Int {
        return elements.index(after: i)
    }

    public subscript(index: Index) -> TableElement {
        return elements[index]
    }
}

// MARK: - ExpressibleByArrayLiteral

public extension TableDataSourceCollection {
    public typealias ArrayLiteralElement = TableElement

    public init(arrayLiteral elements: TableElement...) {
        self.init(elements: elements)
    }
}

// MARK: - SetionCollection
public struct SectionItemCollection: TableDataSourceCollection {
    public typealias TableElement = SectionItemProtocol
    public var elements: [SectionItemProtocol] = []

    public init() {}
}

// MARK: - CellItemCollection
public struct CellItemCollection: TableDataSourceCollection {
    public typealias TableElement = CellItemProtocol
    public var elements: [CellItemProtocol] = []

    public init() {}
}
