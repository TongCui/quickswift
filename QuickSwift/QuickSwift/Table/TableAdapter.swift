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
}

public protocol CellItemProtocol: TableViewRegisterable {
    var settings: CellSettings { get set }
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

public protocol SectionHeaderFooter {
    func view(tableView: UITableView, section: Int) -> UIView?
}

public protocol SectionItemProtocol {
    var cellItems: [CellItemProtocol] { get set }
    var footer: SectionHeaderFooter? { get set }
    var header: SectionHeaderFooter? { get set }
    var settings: SectionSettings { get set }
    func cellItem(index: Int) -> CellItemProtocol?
}

public extension SectionItemProtocol {
    func cellItem(index: Int) -> CellItemProtocol? {
        return cellItems[safe: index]
    }
}

public typealias UITableViewHandler = UITableViewDataSource & UITableViewDelegate

public protocol TableViewAdapterProtocol: UITableViewHandler {
    var sectionItems: [SectionItemProtocol] { get set }
    var settings: TableSettings { get }

    func sectionItem(section: Int) -> SectionItemProtocol?
    func link(tableView: UITableView)
    func generateDataSource()

    init()
    init(tableView: UITableView)

}

public protocol BuiltInCellCustomizable {
    func builtInCellCustomSettings()
}

public extension TableViewAdapterProtocol {

    public init(tableView: UITableView) {
        self.init()
        self.link(tableView: tableView)
    }

    public func link(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }

    public func sectionItem(section: Int) -> SectionItemProtocol? {
        return sectionItems[safe: section]
    }

    public func cellItem(index: Int) -> CellItemProtocol? {
        return sectionItem(section: 0)?.cellItem(index: index)
    }

    public func cellItem(section: Int, index: Int) -> CellItemProtocol? {
        return sectionItem(section: section)?.cellItem(index: index)
    }

    public func cellItem(indexPath: IndexPath) -> CellItemProtocol? {
        return sectionItem(section: indexPath.row)?.cellItem(index: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
// DataSrouce
public extension TableViewAdapterProtocol {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItem(section: section)?.cellItems.count ?? 0
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellItem = cellItem(indexPath: indexPath) {
            return cellItem.cell(tableView: tableView, indexPath: indexPath)
        } else {
            return ErrorCellItem().cell(tableView: tableView, indexPath: indexPath)
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionItem(section: section)?.header?.view(tableView: tableView, section: section)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sectionItem(section: section)?.footer?.view(tableView: tableView, section: section)
    }

}

// MARK: - UITableViewDelegate
// TableView Delegate
public extension TableViewAdapterProtocol {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellItem(indexPath: indexPath)?.settings.cellHeight ?? defaultCellHeight
    }
}
