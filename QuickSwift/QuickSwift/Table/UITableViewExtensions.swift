//
//  UITableViewExtensions.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

extension UITableView {
    private struct AssociatedKey {
        static var cellIds = "cellIds"
        static var headerFooterIds = "headerFooterIds"
    }

    private var cellIds: [String] {
        get {
            return getAssociatedObject(self, key: &AssociatedKey.cellIds, default: [])
        }
        set {
            setAssociatedObject(self, key: &AssociatedKey.cellIds, newValue: newValue)
        }
    }

    private var headerFooterIds: [String] {
        get {
            return getAssociatedObject(self, key: &AssociatedKey.headerFooterIds, default: [])
        }
        set {
            setAssociatedObject(self, key: &AssociatedKey.headerFooterIds, newValue: newValue)
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

    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}
