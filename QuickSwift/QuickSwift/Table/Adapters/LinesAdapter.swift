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

    public lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    public lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)

    public func append(line: String) {
        append(lines: [line])
    }

    public func append(lines: [String]) {
        sections.last?.append {
            lines.map { OneLineTextCellItem(text: $0)}
        }
    }

    public required init() {}

    public convenience init(tableView: UITableView, sectionItem: SectionItemProtocol) {
        self.init(tableView: tableView)
        append(sectionItem: PlainSectionItem())
    }
}
