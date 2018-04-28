//
//  OneLineTextCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class OneLineTextCellItem: CellItemProtocol {

    public var registerType: TableViewRegisterType = .class(OneLineTextCell.self)
    public var identifier: String = "oneline_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public var text: String

    public init(text: String) {
        self.text = text
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? OneLineTextCell {
            cell.oneLineLabel.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(cellConfigurator.cellContentEdges)
            }
            cell.oneLineLabel.text = text
        }
    }
}

open class OneLineAttributedTextCellItem: CellItemProtocol {

    public var registerType: TableViewRegisterType = .class(OneLineTextCell.self)
    public var identifier: String = "oneline_attributed_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public let attributedText: NSAttributedString

    public init(attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? OneLineTextCell {
            cell.oneLineLabel.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(cellConfigurator.cellContentEdges)
            }
            cell.oneLineLabel.attributedText = attributedText
        }
    }
}

open class OneLineTextCell: CommonInitTableCell {

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
