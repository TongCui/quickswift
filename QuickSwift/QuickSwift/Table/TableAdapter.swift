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

public protocol CellItemProtocol: TableViewRegisterable {
    var settings: CellSettings { get set }
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

public protocol SectionHeaderFooterProtocol: TableViewRegisterable {
    func view(tableView: UITableView, section: Int) -> UIView?
    var title: String? { get set }
    var indexTitle: String? { get set }
    var height: CGFloat { get set }
}

public protocol SectionItemProtocol {
    var cellItems: CellItemCollection { get set }
    var footer: SectionHeaderFooterProtocol? { get set }
    var header: SectionHeaderFooterProtocol? { get set }
    var settings: SectionSettings { get set }
    
    mutating func appendCellItem(_ cellItem: CellItemProtocol)
    mutating func removeCellItem(_ cellItem: CellItemProtocol)
}

extension SectionItemProtocol {
    public mutating func appendCellItem(_ cellItem: CellItemProtocol) {
        cellItems.append(cellItem)
    }
    
    public mutating func removeCellItem(_ cellItem: CellItemProtocol) {
    
    }
}

public protocol TableViewAdapterProtocol {
    var sections: SectionCollection { get set }
    var settings: TableSettings { get set }
    weak var tableView: UITableView? { get set }
    init(tableView: UITableView?)
    func link(tableView: UITableView)
    func reloadData()
    
    var dataSourceHandler: TableViewDataSourceHandler? { get set }
    var delegateHandler: TableViewDelegateHandler? { get set }
}

public extension TableViewAdapterProtocol {
    public func reloadData() {
        self.tableView?.reloadData()

    }

    public mutating func link(tableView: UITableView) {
        tableView.dataSource = dataSourceHandler
        tableView.delegate = delegateHandler
        self.tableView = tableView
    }
}



