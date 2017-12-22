//
//  OneLineTextCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import SnapKit

struct OneLineTextCellItem: CellItemProtocol {

    var text: String?
    var identifier: String = "oneline_cell"
    var settings: CellSettings = CellSettings()

    init(text: String) {
        self.text = text
    }

    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? OneLineTextCell {
            cell.oneLineLabel.text = text
        }

        return tableCell
    }

}

class OneLineTextCell: BuiltInCell {

    lazy var oneLineLabel = UILabel()

    override func commonInit() {
        super.commonInit()
        contentView.addSubview(oneLineLabel)
        let margin: CGFloat = 20
        oneLineLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        }
    }
}
