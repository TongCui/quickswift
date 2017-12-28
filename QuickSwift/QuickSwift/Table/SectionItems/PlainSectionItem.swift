//
//  PlainSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation


public class PlainSectionItem: SectionItemProtocol {
    public var cellItems: CellItemCollection = CellItemCollection(cellItems: [])
    
    public func removeCellItem(_ cellItem: CellItemProtocol) {
        
    }
    
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?

    public var settings: SectionSettings = SectionSettings()
    
    public init() {
        
    }
}
