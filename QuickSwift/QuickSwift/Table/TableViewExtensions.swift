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

    func registerIfNeeded(cell registerable: TableViewRegisterable) {
        guard !cellIds.contains(registerable.identifier) else {
            return
        }

        cellIds.append(registerable.identifier)
        registerable.register(tableView: self)
    }

    func registerIfNeeded(headerFooter registerable: TableViewRegisterable) {
        guard !headerFooterIds.contains(registerable.identifier) else {
            return
        }

        headerFooterIds.append(registerable.identifier)
        registerable.register(tableView: self)
    }
}
