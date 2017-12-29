//
//  TableHandler.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol TableHandlerProtocol {
    var adapter: TableViewAdapterProtocol { get }
    init(adapter: TableViewAdapterProtocol)
}

public class TableViewDataSourceHandler: NSObject, TableHandlerProtocol {
    public var adapter: TableViewAdapterProtocol
    public required init(adapter: TableViewAdapterProtocol) {
        self.adapter = adapter
    }
}

extension TableViewDataSourceHandler: UITableViewDataSource {

    // MARK: - Configuring a Table View
    public func numberOfSections(in tableView: UITableView) -> Int {
        return adapter.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapter.sections[safe: section]?.cellItems.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = adapter.cellItem(indexPath: indexPath)
        tableView.register(cellItem)
        return cellItem.cell(tableView: tableView, indexPath: indexPath)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return adapter.sections[safe: section]?.settings.header?.title
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return adapter.sections[safe: section]?.settings.footer?.title
    }

    // MARK: - Configuring an Index
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let titles = adapter.sections.flatMap { $0.settings.indexTitle }

        guard titles.count > 0 else {
            return nil
        }

        return titles
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}

public class TableViewDelegateHandler: NSObject, TableHandlerProtocol {
    public var adapter: TableViewAdapterProtocol
    public required init(adapter: TableViewAdapterProtocol) {
        self.adapter = adapter
    }
}

extension TableViewDelegateHandler: UITableViewDelegate {
    // MARK: - Configuring Rows for the Table View
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adapter.cellItem(indexPath: indexPath).settings.cellHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        adapter.cellItem(indexPath: indexPath).cell(tableView: tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        adapter.cellItem(indexPath: indexPath).cell(tableView: tableView, willDisplay: cell, forRowAt: indexPath)
    }
}
