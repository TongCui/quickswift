//
//  UITableViewExtensions.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

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

    func registerCellIfNeeded(_ registerable: TableViewRegisterable) {
        guard !cellIds.contains(registerable.identifier) else {
            return
        }

        cellIds.append(registerable.identifier)

        switch registerable.registerType {
        case .none:                     break
        case .class(let anyClass):      register(anyClass, forCellReuseIdentifier: registerable.identifier)
        case .nib(let nib):             register(nib, forCellReuseIdentifier: registerable.identifier)
        }
    }

    func registerHeaderFooterIfNeeded(_ registerable: TableViewRegisterable) {
        guard !headerFooterIds.contains(registerable.identifier) else {
            return
        }

        headerFooterIds.append(registerable.identifier)

        switch registerable.registerType {
        case .none:                     break
        case .class(let anyClass):      register(anyClass, forHeaderFooterViewReuseIdentifier: registerable.identifier)
        case .nib(let nib):             register(nib, forHeaderFooterViewReuseIdentifier: registerable.identifier)
        }
    }

    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    public func reloadData(after delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.reloadData()
        }
    }

    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}
