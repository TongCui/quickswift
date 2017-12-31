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
    func cell(tableView: UITableView, didSelectRowAt index: IndexPath)
    func cell(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

public extension CellItemProtocol {
    func cell(tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
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

class TestSection: SectionItemProtocol {
    required init() {

    }
    var cellItems: [CellItemProtocol] = []

    var settings: SectionSettings = SectionSettings()
}

func test() {
    let section = TestSection()

    print("section \(section)")
}

public protocol TableViewAdapterProtocol: AnyObject {
    var sections: [SectionItemProtocol] { get set }
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

class TestAdapter: TableViewAdapterProtocol {
    var dataSourceHandler: TableViewDataSourceHandler?

    var delegateHandler: TableViewDelegateHandler?

    var sections: [SectionItemProtocol] = []

    required init() {

    }

    var settings: TableSettings = TableSettings()

    var tableView: UITableView?

}

public extension TableViewAdapterProtocol {
    typealias TableElement = SectionItemProtocol

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
        let section = T.init()
        section.cellItems.append(contentsOf: cellItems())
        sections.append(section)
    }

    func append<T: SectionItemProtocol>(section type: T.Type, dataSource: () -> [[CellItemProtocol]]) {

        dataSource().forEach { (cellItems) in
            append(section: type) { cellItems }
        }
    }
}
