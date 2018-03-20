//
//  OneLineTextCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class OneLineTextCellItem: CellItemProtocol {
    public var text: String
    public var identifier: String = "oneline_cell"
    public var settings: CellSettings = CellSettings()

    public init(text: String) {
        self.text = text
    }

    public func register(tableView: UITableView) {
        tableView.register(OneLineTextCell.self, forCellReuseIdentifier: identifier)
    }

    open func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? OneLineTextCell {
            cell.oneLineLabel.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(cellContentEdges)
            }
            cell.oneLineLabel.text = text
        }

        return tableCell
    }

}

open class OneLineTextCell: BuiltInCell {

    public lazy var oneLineLabel = UILabel()

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(oneLineLabel)
        oneLineLabel.numberOfLines = 0
        oneLineLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(margin: .defaultMargin))
        }
    }
}
