//
//  TableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

let defaultCellHeight: CGFloat = 44

public protocol TableViewRegisterable {
    var identifier: String { get set }
    func register(tableView: UITableView)
}

public protocol CellItemProtocol: AnyObject, TableViewRegisterable {
    var settings: CellSettings { get set }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func cell(tableView: UITableView, didSelectRowAt index: IndexPath)
    func cell(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

// MARK: - Default Implementation
public extension CellItemProtocol {
    func cell(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
}

public protocol SectionHeaderFooterProtocol: TableViewRegisterable {
    func view(tableView: UITableView, section: Int) -> UIView?
    var title: String? { get set }
    var height: CGFloat { get set }
}

public protocol SectionItemProtocol: AnyObject {
    var cellItems: CellItemCollection { get set }
    var settings: SectionSettings { get set }

    init()

    func append(_ cellItem: CellItemProtocol)
    func append(contentsOf contents: () -> [CellItemProtocol])
    func safeRemove(_ cellItem: CellItemProtocol)
    func safeRemove(row: Int)
    func removeAll()
    func removeLast()
    func safeInsert(_ cellItem: CellItemProtocol, row: Int)
}

public extension SectionItemProtocol {

    public func append(_ cellItem: CellItemProtocol) {
        cellItems.append(cellItem)
    }

    func append(contentsOf contents: () -> [CellItemProtocol]) {
        cellItems.append(contentsOf: contents())
    }

    public func safeRemove(_ cellItem: CellItemProtocol) {
        if let index = cellItems.index(where: { $0 === cellItem}) {
            cellItems.safeRemove(at: index)
        }
    }

    public func safeRemove(row: Int) {
        cellItems.safeRemove(at: row)
    }

    public func removeAll() {
        cellItems.removeAll()
    }

    public func removeLast() {
        cellItems.removeLast()
    }

    public func safeInsert(_ cellItem: CellItemProtocol, row: Int) {
        cellItems.safeInsert(cellItem, at: row)
    }
}

public protocol TableViewAdapterProtocol: class {
    var sections: SectionItemCollection { get set }
    var settings: TableSettings { get set }

    weak var tableView: UITableView? { get set }

    init()
    init(tableView: UITableView?)

    func link(tableView: UITableView)
    func reloadData()

    func cellItem(section: Int, row: Int) -> CellItemProtocol
    func cellItem(indexPath: IndexPath) -> CellItemProtocol

    var dataSourceHandler: TableViewDataSourceHandler? { get set }
    var delegateHandler: TableViewDelegateHandler? { get set }
}

public extension TableViewAdapterProtocol {
    init(tableView: UITableView?) {
        self.init()
        if let tableView = tableView {
            link(tableView: tableView)
        }
    }

    public func reloadData() {
        self.tableView?.reloadData()
    }

    public func link(tableView: UITableView) {
        tableView.dataSource = dataSourceHandler
        tableView.delegate = delegateHandler
        self.tableView = tableView
    }

    func cellItem(section: Int, row: Int) -> CellItemProtocol {
        return sections[safe: section]?.cellItems[safe: row] ?? ErrorCellItem()
    }

    func cellItem(indexPath: IndexPath) -> CellItemProtocol {
        return cellItem(section: indexPath.section, row: indexPath.row)
    }

    func append<T: SectionItemProtocol>(section type: T.Type, cellItems: () -> [CellItemProtocol]) {
        let sectionItem = T.init()
        sectionItem.append { cellItems() }
        sections.append(sectionItem)
    }

    func append<T: SectionItemProtocol>(section type: T.Type, dataSource: () -> [[CellItemProtocol]]) {
        let sectionItems = dataSource().map { cellItems -> T in
            let sectionItem = T.init()
            sectionItem.append { cellItems }
            return sectionItem
        }
        sections.append(contentsOf: sectionItems)
    }
}
