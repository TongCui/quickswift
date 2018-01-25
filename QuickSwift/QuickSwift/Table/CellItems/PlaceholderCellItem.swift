//
//  PlaceholderCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class PlaceholderCellItem: CellItemProtocol {

    public var identifier: String = "placeholder_cell"
    public var settings: CellSettings = CellSettings()

    public init(height: CGFloat) {
        cellHeight = height
        cellSeparatorStyle = .none
    }

    public func register(tableView: UITableView) {
        tableView.register(PlaceholderCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? PlaceholderCell {
            cell.selectionStyle = .none
        }

        return tableCell
    }
}

public class PlaceholderCell: BuiltInCell {

    public override func commonInit() {
        super.commonInit()
    }
}
