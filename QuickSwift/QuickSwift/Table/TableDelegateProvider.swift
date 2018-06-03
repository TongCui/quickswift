//
//  TableDelegateProvider.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

public protocol TableDelegateProvider: UITableViewDelegate, DataSourceAccessor {
    var scrollDelegate: UIScrollViewDelegate? { get set }
}

extension TableDelegateProvider {
    func tableParams(tableView: UITableView, indexPath: IndexPath, cell: UITableViewCell?) -> TableParams {
        let params = TableParams { (make) in
            make.cell = cell
            make.tableView = tableView
            make.indexPath = indexPath
        }
        return params
    }
}

open class BasicTableDelegateProvider: NSObject, TableDelegateProvider {
    open var getSections: () -> [SectionItemProtocol]
    open var scrollDelegate: UIScrollViewDelegate?
    open var cellHeights: [IndexPath: CGFloat] = [:]

    public init(getSections: @escaping () -> [SectionItemProtocol]) {
        self.getSections = getSections
    }

    // MARK: - Configuring Rows for the Table View
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellItem(indexPath: indexPath)?.cellConfigurator.cellHeight ?? .defaultCellHeight
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let params = tableParams(tableView: tableView, indexPath: indexPath, cell: cell)
        if let cellItem = getCellItem(indexPath: indexPath) {
            cellItem.actionHandler.getHandler(for: .cellWillDisplay)?(params)
            cellItem.cellDisplayingContext.cell(willDisplay: cell, tableView: tableView, indexPath: indexPath)
        }

        cellHeights[indexPath] = cell.frame.size.height
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else {
            return self.tableView(tableView, heightForRowAt:indexPath)
        }
        return height
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let params = tableParams(tableView: tableView, indexPath: indexPath, cell: cell)
        if let cellItem = getCellItem(indexPath: indexPath) {
            cellItem.actionHandler.getHandler(for: .cellDidEndDisplaying)?(params)
            cellItem.cellDisplayingContext.cell(didEndDisplaying: cell, tableView: tableView, indexPath: indexPath)
        }
    }

    // MARK: - Managing Selections
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let params = tableParams(tableView: tableView, indexPath: indexPath, cell: tableView.cellForRow(at: indexPath))
        getCellItem(indexPath: indexPath)?.actionHandler.getHandler(for: .cellDidSelect)?(params)
    }

}

public extension BasicTableDelegateProvider {

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

open class HeaderFooterDelegateHandler: BasicTableDelegateProvider {
    // MARK: - Modifying the Header and Footer of Sections
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let header = getSectionItem(section: section)?.header else {
            return nil
        }

        tableView.registerHeaderFooterIfNeeded(header)

        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier) else {
            return nil
        }

        header.render(view: view)
        return view
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getSectionItem(section: section)?.header?.height ?? defaultHeaderHeight(tableView:tableView, section:section)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = getSectionItem(section: section)?.footer else {
            return nil
        }

        tableView.registerHeaderFooterIfNeeded(footer)

        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.identifier) else {
            return nil
        }

        footer.render(view: view)
        return view
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return getSectionItem(section: section)?.footer?.height ?? 0
    }

    private func defaultHeaderHeight(tableView: UITableView, section: Int) -> CGFloat {
        switch tableView.style {
        case .plain:
            return 0
        case .grouped:
            return section == 0 ? .tableHeaderDefaultHeight : 0
        }
    }
}
