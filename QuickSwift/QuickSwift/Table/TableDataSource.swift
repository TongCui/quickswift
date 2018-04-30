//
//  TableDataSource.swift
//  TableAdapter
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

/// TableView Datasource Components : CellItem or SectionItem
public protocol DataSourceElement: AnyObject {}

/// SectionItems Container
public protocol DataSourceAccessor {
    var getSections: () -> [SectionItemProtocol] { get }
}

// MARK: - Get SectionItem or CellItem from IndexPath
public extension DataSourceAccessor {
    public func getSectionItem(section: Int) -> SectionItemProtocol? {
        return getSections()[safe: section]
    }

    public func getSectionItem(indexPath: IndexPath) -> SectionItemProtocol? {
        return getSectionItem(section: indexPath.section)
    }

    public func getCellItem(section: Int, row: Int) -> CellItemProtocol? {
        return getSections()[safe: section]?.cellItems[safe: row]
    }

    public func getCellItem(indexPath: IndexPath) -> CellItemProtocol? {
        return getCellItem(section: indexPath.section, row: indexPath.row)
    }
}
