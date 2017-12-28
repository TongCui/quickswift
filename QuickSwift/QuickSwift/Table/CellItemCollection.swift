//
//  CellItems.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation


public struct CellItemCollection {
    public typealias ArrayType = [CellItemProtocol]
    var cellItems: [CellItemProtocol] = []
    
    public init(cellItems: [CellItemProtocol]) {
        self.cellItems = cellItems
    }
    
    public init() {}
}

extension CellItemCollection: MutableCollection, RangeReplaceableCollection {
    
    public typealias Index = CellItemCollection.ArrayType.Index
    public typealias Element = CellItemCollection.ArrayType.Element
    
    public var startIndex: Index { return cellItems.startIndex }
    public var endIndex: Index { return cellItems.endIndex }
    
    public func index(after i: CellItemCollection.ArrayType.Index) -> CellItemCollection.ArrayType.Index {
        return cellItems.index(after: i)
    }
    
    public subscript(index: Index) -> CellItemProtocol {
        get {
            return cellItems[index]
        }
        set(newValue) {
            cellItems[index] = newValue
        }
        
    }
    
    public subscript(safe index: Index) -> CellItemProtocol? {
        get {
            return cellItems[safe: index]
        }
        set(newValue) {
            //TODO
        }
    }
}

extension CellItemCollection: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = CellItemProtocol
    
    public init(arrayLiteral cellItems: CellItemProtocol...) {
        self.init(cellItems)
    }
}
