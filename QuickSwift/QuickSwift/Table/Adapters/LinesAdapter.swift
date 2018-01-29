//
//  LinesAdapter.swift
//  QuickSwift
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public class LinesAdapter: TableViewAdapterProtocol {

    public weak var tableView: UITableView?
    public var sections: [SectionItemProtocol] = []
    private var lines: [String] = []
    private var sectionItem: SectionItemProtocol = PlainSectionItem()

    public lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    public lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)

    public func append(line: String) {
        lines.append(line)
    }

    public func append(lines: [String]) {
        self.lines.append(contentsOf: lines)
    }

    public required init() {}

    public convenience init(tableView: UITableView, sectionItem: SectionItemProtocol) {
        self.init(tableView: tableView)
        self.sectionItem = sectionItem
    }

    public func reloadData() {
        clear()
        append(sectionItem)
        sectionItem.clear()
        sectionItem.append { lines.map { OneLineTextCellItem(text: $0) } }
        reloadTableView()
    }
}
