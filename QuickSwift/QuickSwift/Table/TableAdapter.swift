//
//  TableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

let defaultCellHeight: CGFloat = 44

public protocol DataSourceElement: AnyObject {

}

public protocol TableViewRegisterable {
    var identifier: String { get set }
    func register(tableView: UITableView)
}

public protocol CellItemProtocol: TableViewRegisterable, DataSourceElement {
    var settings: CellSettings { get set }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    var cellHeight: CGFloat {get set}
    func actionHandler(_ action: CellSettings.Actions) -> ((TableParams) -> Void)?
}

public extension CellItemProtocol {
    var tableView: UITableView? {
        return settings.tableView
    }

    var indexPath: IndexPath? {
        return settings.indexPath
    }

    func parentViewController<T: UIViewController>() -> T? {
        return self.tableView?.parentViewController()
    }

    var cellHeight: CGFloat {
        get {
            return settings.cellHeight
        }
        set {
            settings.cellHeight = newValue
        }
    }

    func cell(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}

    @discardableResult
    func add(action: CellSettings.Actions, handler: @escaping (TableParams) -> Void) -> Self {
        settings.actions[action] = handler
        return self
    }

    func actionHandler(_ action: CellSettings.Actions) -> ((TableParams) -> Void)? {
        return settings.actions[action]
    }
}

public protocol SectionHeaderFooterProtocol: TableViewRegisterable {
    func view(tableView: UITableView, section: Int) -> UIView?
    var title: String? { get set }
    var height: CGFloat { get set }
}

public protocol SectionItemProtocol: DataSourceElement {
    var cellItems: [CellItemProtocol] { get set }
    var settings: SectionSettings { get set }

    init()
}

public protocol TableViewAdapterProtocol: AnyObject {
    var sections: [SectionItemProtocol] { get set }
    var settings: TableSettings { get set }

    init()
    init(tableView: UITableView, viewController: UIViewController)

    func link(tableView: UITableView)
    func reloadData()

    func cellItem<T>(at indexPath: IndexPath) -> T?
    func firstCellItem<T>(in section: Int) -> T?
    func lastCellItem<T>(in section: Int) -> T?

    var dataSourceHandler: TableDataSourceHandlerProtocol? { get set }
    var delegateHandler: TableDelegateHandlerProtocol? { get set }
}

public extension TableViewAdapterProtocol {
    typealias TableElement = SectionItemProtocol

    init(tableView: UITableView, viewController: UIViewController) {
        self.init()
        link(tableView: tableView)
        link(viewController: viewController)
    }

    public func reloadData() {
        self.settings.tableView?.reloadData()
    }

    public func link(tableView: UITableView) {
        tableView.dataSource = dataSourceHandler
        tableView.delegate = delegateHandler
        self.settings.tableView = tableView
    }

    public func link(viewController: UIViewController) {
        self.settings.viewController = viewController
    }

    func cellItem(section: Int, row: Int) -> CellItemProtocol {
        return sections[safe: section]?.cellItems[safe: row] ?? ErrorCellItem()
    }

    func cellItem(indexPath: IndexPath) -> CellItemProtocol {
        return cellItem(section: indexPath.section, row: indexPath.row)
    }

    public func cellItem<T>(at indexPath: IndexPath) -> T? {
        return cellItem(indexPath: indexPath) as? T
    }

    public func firstCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.first { $0 is T } as? T
    }

    public func lastCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.reversed().first { $0 is T } as? T
    }

    public func append<T: SectionItemProtocol>(section type: T.Type, cellItems: () -> [CellItemProtocol]) {
        let section = T.init()
        section.cellItems.append(contentsOf: cellItems())
        sections.append(section)
    }

    public func append<T: SectionItemProtocol>(section type: T.Type, dataSource: () -> [[CellItemProtocol]]) {

        dataSource().forEach { (cellItems) in
            append(section: type) { cellItems }
        }
    }
}
