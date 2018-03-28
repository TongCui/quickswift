//
//  TableAdapterCell.swift
//  QuickSwift
//
//  Created by tcui on 27/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

open class TableAdapterCellItem: CellItemProtocol {
    public var identifier: String = "table_adapter_cell"
    public var settings: CellSettings = CellSettings()
    public var adapter: TableViewAdapterProtocol

    public init(adapter: TableViewAdapterProtocol) {
        self.adapter = adapter
    }

    public func register(tableView: UITableView) {
        tableView.register(TableAdapterCell.self, forCellReuseIdentifier: identifier)
    }

    open func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? TableAdapterCell {

            adapter.link(tableView: cell.contentTableView)
            adapter.hidePlainTaleBottomCells()
            cell.contentTableView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
//            cell.contentTableView.isScrollEnabled = false
            adapter.reloadData()

            cell.contentTableView.snp.updateConstraints { (make) in
                make.height.equalTo(cell.contentTableView.contentSize.height)
            }

            print("\(indexPath))  ContentSize : \(cell.contentTableView.contentSize) - ContentOffset: \(cell.contentTableView.contentOffset) ")
        }
        return tableCell
    }
}

open class TableAdapterCell: BuiltInCell {

    public lazy var contentTableView = UITableView(frame: CGRect.zero, style: .plain)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(contentTableView)
        //  In iOS 11, table views use estimated heights by default. This means that the contentSize is just as estimated value initially. If you need to use the contentSize, you’ll want to disable estimated heights by setting the 3 estimated height properties to zero: tableView.estimatedRowHeight = 0 tableView.estimatedSectionHeaderHeight = 0 tableView.estimatedSectionFooterHeight = 0
        contentTableView.estimatedRowHeight = 0
        contentTableView.estimatedSectionFooterHeight = 0
        contentTableView.estimatedSectionHeaderHeight = 0
        contentTableView.translatesAutoresizingMaskIntoConstraints = false

        contentTableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
            make.height.equalTo(100)
        }
    }
}
