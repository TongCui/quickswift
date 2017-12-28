//
//  TableViewExtensions.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

private struct TableViewPropertyKeys {
    static var cellIdsKey: UInt8 = 0
    static var headerFooterIdsKey: UInt8 = 1
}

extension UITableView {
    private var cellIds: [String] {
        get {
            return getAssociatedObject(self, key: &TableViewPropertyKeys.cellIdsKey, default: [])
        }
        set {
            setAssociatedObject(self, key: &TableViewPropertyKeys.cellIdsKey, newValue: newValue)
        }
    }
    
    private var headerFooterIds: [String] {
        get {
            return getAssociatedObject(self, key: &TableViewPropertyKeys.headerFooterIdsKey, default: [])
        }
        set {
            setAssociatedObject(self, key: &TableViewPropertyKeys.headerFooterIdsKey, newValue: newValue)
        }
    }
    
    func register(cell: TableViewRegisterable) {
        if !cellIds.contains(cell.identifier) {
            cell.register(tableView: self)
        }
    }
    
    func register(headerOrFooter view: TableViewRegisterable) {
        if !headerFooterIds.contains(view.identifier) {
            view.register(tableView: self)
        }
    }
}
