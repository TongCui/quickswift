//
//  PlaceholderCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class PlaceholderCellItem: CellItemProtocol {

    public var registerType: TableViewRegisterType = .class(PlaceholderCell.self)
    public var identifier: String = "placeholder_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public init(height: CGFloat) {
        cellConfigurator.cellHeight = height
        cellConfigurator.cellSeparatorStyle = .none
    }

    open func bind(cell: UITableViewCell) {
        cell.selectionStyle = .none
    }
}

public class PlaceholderCell: CommonInitTableCell {
    public override func commonInit() {
        super.commonInit()
    }
}
