//
//  TableDataSourceProvider.swift
//  TableAdapter
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public protocol TableDataSourceProvider: UITableViewDataSource, DataSourceAccessor {

}

open class BasicDataSourceProvider: NSObject, TableDataSourceProvider {
    open var getSections: () -> [SectionItemProtocol]

    public init(getSections: @escaping () -> [SectionItemProtocol]) {
        self.getSections = getSections
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return getSections().count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSectionItem(section: section)?.cellItems.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellItem = getCellItem(indexPath: indexPath) else {
            return UITableViewCell()
        }

        tableView.registerCellIfNeeded(cellItem)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItem.identifier, for: indexPath)
        cellItem.bind(cell: cell)
        cellItem.cellConfigurator.configue(cell: cell)

        return cell
    }
}

open class HeaderFooterDataSourceProvider: BasicDataSourceProvider {

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getSectionItem(section: section)?.header?.title
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return getSectionItem(section: section)?.footer?.title
    }

    // MARK: - Configuring an Index
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let titles = getSections().compactMap { $0.indexTitle }

        guard titles.count > 0 else {
            return nil
        }

        return titles
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}
