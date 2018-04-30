//
//  TableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

/// TableView Adapter
public protocol TableViewAdapterProtocol: AnyObject, DataSourceAccessor {

    /// SectionItems
    var sections: [SectionItemProtocol] { get set }

    /// TableView
    var tableView: UITableView? { get set }

    /// TableViweDataSource Implementation
    var dataSourceProvider: TableDataSourceProvider { get set }

    /// TableViweDelegate Implementation
    var delegateProvider: TableDelegateProvider { get set }

    init()
    init(tableView: UITableView)
    func link(tableView: UITableView)
}

// MARK: - Default Implememtations
public extension TableViewAdapterProtocol {

    var getSections: () -> [SectionItemProtocol] {
        return { self.sections }
    }

    public func parentViewController<T: UIViewController>() -> T? {
        return tableView?.parentViewController()
    }

    public init(tableView: UITableView) {
        self.init()
        link(tableView: tableView)
    }

    public func reloadData() {
        tableView?.reloadData()
    }

    public func clear() {
        sections.removeAll()
        tableView?.reloadData()
    }

    public func link(tableView: UITableView) {
        tableView.dataSource = dataSourceProvider
        tableView.delegate = delegateProvider
        self.tableView = tableView
    }

    public func hidePlainTaleBottomCells() {
        guard let tableView = self.tableView else {
            return
        }

        tableView.tableFooterView = UIView()
    }
}

// MARK: - DataSource Management
public extension TableViewAdapterProtocol {
    public func cellItem<T>(at indexPath: IndexPath) -> T? {
        return getCellItem(indexPath: indexPath) as? T
    }

    public func firstCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.first { $0 is T } as? T
    }

    public func lastCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.reversed().first { $0 is T } as? T
    }

    @discardableResult
    public func append(sectionItem: SectionItemProtocol) -> Self {
        sections.append(sectionItem)
        return self
    }

    @discardableResult
    public func append(sectionItems: [SectionItemProtocol]) -> Self {
        sections.append(contentsOf: sectionItems)
        return self
    }

    @discardableResult
    public func append<T: SectionItemProtocol>(section: T, cellItems: () -> [CellItemProtocol]) -> Self {
        section.cellItems.append(contentsOf: cellItems())
        sections.append(section)
        return self
    }
}

/** Animations */
public extension TableViewAdapterProtocol {
    public func append(cellItem: CellItemProtocol, animated: UITableViewRowAnimation = .none) {
        sections.last?.append(cellItem)
    }

    public func append(cellItems: [CellItemProtocol], animated: UITableViewRowAnimation = .none) {

    }

    public func insert(cellItem: CellItemProtocol, at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func insert(cellItems: [CellItemProtocol], at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(cellItem: CellItemProtocol, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(cellItems: [CellItemProtocol], animated: UITableViewRowAnimation = .none) {

    }

    public func remove(at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(at indexPaths: [IndexPath], animated: UITableViewRowAnimation = .none) {

    }

}

public final class TableParams {
    public var indexPath: IndexPath?
    public var cell: UITableViewCell?
    public var tableView: UITableView?

    public init(builder: (TableParams) -> Void) {
        builder(self)
    }
}
