//
//  TableHandler.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public let kTableEmptyHeight: CGFloat = 0.01

public protocol TableHandlerProtocol {
    var adapter: TableViewAdapterProtocol { get }
    init(adapter: TableViewAdapterProtocol)
}

public protocol TableDataSourceHandlerProtocol: TableHandlerProtocol, UITableViewDataSource {

}

public class TableViewDataSourceHandler: NSObject, TableDataSourceHandlerProtocol {
    public var adapter: TableViewAdapterProtocol
    public required init(adapter: TableViewAdapterProtocol) {
        self.adapter = adapter
    }

    // MARK: - Configuring a Table View
    public func numberOfSections(in tableView: UITableView) -> Int {
        return adapter.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapter.sections[safe: section]?.cellItems.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = adapter.cellItem(indexPath: indexPath)

        tableView.registerIfNeeded(cell: cellItem)
        cellItem.settings.tableView = tableView
        cellItem.settings.indexPath = indexPath

        let cell = cellItem.cell(tableView: tableView, indexPath: indexPath)
        cell.update(with: cellItem.settings)

        return cell
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

public protocol TableDelegateHandlerProtocol: TableHandlerProtocol, UITableViewDelegate {
    var scrollDelegate: UIScrollViewDelegate? { get set }
}

public class TableViewDefaultDelegateHandler: NSObject, TableDelegateHandlerProtocol {
    public var adapter: TableViewAdapterProtocol
    public var scrollDelegate: UIScrollViewDelegate?
    public required init(adapter: TableViewAdapterProtocol) {
        self.adapter = adapter
    }

    // MARK: - Configuring Rows for the Table View
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adapter.cellItem(indexPath: indexPath).settings.cellHeight
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellItem = adapter.cellItem(indexPath: indexPath)
        let params = TableParams { (make) in
            make.cellItem = cellItem
            make.cell = cell
            make.tableView = tableView
            make.indexPath = indexPath
        }

        cellItem.handler(for: .cellWillDisplay)?(params)
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellItem = adapter.cellItem(indexPath: indexPath)
        let params = TableParams { (make) in
            make.cellItem = cellItem
            make.cell = cell
            make.tableView = tableView
            make.indexPath = indexPath
        }

        cellItem.handler(for: .cellDidEndDisplaying)?(params)
    }

    // MARK: - Managing Selections

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let cellItem = adapter.cellItem(indexPath: indexPath)
        let params = TableParams { (make) in
            make.cellItem = cellItem
            make.tableView = tableView
            make.indexPath = indexPath
        }

        cellItem.handler(for: .cellDidSelect)?(params)
    }

    // MARK: - Modifying the Header and Footer of Sections
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = adapter.sections[safe: section]
        return sectionItem?.settings.header?.view(tableView: tableView, section: section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionItem = adapter.sections[safe: section]
        return sectionItem?.settings.header?.height ?? 0
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = adapter.sections[safe: section]
        return sectionItem?.settings.footer?.view(tableView: tableView, section: section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionItem = adapter.sections[safe: section]
        return sectionItem?.settings.footer?.height ?? 0
    }
}

public extension TableViewDefaultDelegateHandler {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }

    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return scrollDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }

    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }

}
