//
//  SequenceExtensions.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

// MARK: - Conditions

public extension Sequence {
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

public extension Sequence {
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
