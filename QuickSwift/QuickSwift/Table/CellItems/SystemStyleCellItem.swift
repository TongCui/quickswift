//
//  SystemStyleCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class SystemStyleCellItem: CellItemProtocol {
    public var identifier: String
    public var settings: CellSettings = CellSettings()
    public var style: UITableViewCellStyle = .default

    public init(style: UITableViewCellStyle) {
        self.identifier = "system_style_cell_\(style.rawValue) "
        self.style = style
        settings.cellHeight = kDefaultCellHeight
    }

    public func register(tableView: UITableView) {
        //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        //  Do nothing
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell: UITableViewCell

        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            tableCell = cell
        } else {
            tableCell = UITableViewCell(style: style, reuseIdentifier: identifier)
        }

        return tableCell
    }
}
