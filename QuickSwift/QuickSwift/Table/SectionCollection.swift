//
//  TableSectionCollection.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct SectionCollection {
    public typealias ArrayType = [SectionItemProtocol]
    var sections: [SectionItemProtocol] = []
    
    public init(sections: [SectionItemProtocol]) {
        self.sections = sections
    }
    
    public init() {}
}

extension SectionCollection: MutableCollection, RangeReplaceableCollection {
    
    public typealias Index = SectionCollection.ArrayType.Index
    public typealias Element = SectionCollection.ArrayType.Element
    
    public var startIndex: Index { return sections.startIndex }
    public var endIndex: Index { return sections.endIndex }
    
    public func index(after i: SectionCollection.ArrayType.Index) -> SectionCollection.ArrayType.Index {
        return sections.index(after: i)
    }
    
    public subscript(index: Index) -> SectionItemProtocol {
        get {
            return sections[index]
        } set(newValue) {
            sections[index] = newValue
        }
        
    }
    
    public subscript(safe index: Index) -> SectionItemProtocol? {
        get {
            return sections[safe: index]
        }
        set(newValue) {
            //TODO
        }
    }
    
    public subscript(section: Int, row: Int) -> CellItemProtocol? {
        get {
            return sections[section].cellItems[row]
        }
        set(newValue) {
            if let cellItem = newValue {
                print("cellitem is \(cellItem)")
                //  TODO: insert it
            } else {
                //TODO: remove it
            }
        }
    }
    
    public subscript(index: IndexPath) -> CellItemProtocol? {
        get {
            return self[index.section, index.row]
        }
        set(newValue) {
            self[index.section, index.row] = newValue
        }
    }
    
}

extension SectionCollection: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = SectionItemProtocol
    
    public init(arrayLiteral sections: SectionItemProtocol...) {
        self.init(sections)
    }
}
