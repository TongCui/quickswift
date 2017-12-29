//
//  TableViewExtensions.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

private struct UITableViewPropertyKeys {
    static var cellIdsKey: UInt8 = 0
    static var headerFooterIdsKey: UInt8 = 1
}

extension UITableView {
    private var cellIds: [String] {
        get {
            return getAssociatedObject(self, key: &UITableViewPropertyKeys.cellIdsKey, default: [])
        }
        set {
            setAssociatedObject(self, key: &UITableViewPropertyKeys.cellIdsKey, newValue: newValue)
        }
    }

    private var headerFooterIds: [String] {
        get {
            return getAssociatedObject(self, key: &UITableViewPropertyKeys.headerFooterIdsKey, default: [])
        }
        set {
            setAssociatedObject(self, key: &UITableViewPropertyKeys.headerFooterIdsKey, newValue: newValue)
        }
    }

    func register(_ registerable: TableViewRegisterable) {
        if !cellIds.contains(registerable.identifier) {
            registerable.register(tableView: self)
        }
    }

}
