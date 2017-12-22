//
//  ErrorCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

struct ErrorCellItem: CellItemProtocol {
    var identifier: String = "error_cell"

    var raw: Any?

    var settings = CellSettings()

    init() {

    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: identifier)
    }
}
