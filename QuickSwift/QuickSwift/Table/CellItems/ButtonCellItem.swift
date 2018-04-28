//
//  ButtonCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class ButtonCellItem: CellItemProtocol {
    public var registerType: TableViewRegisterType = .class(ButtonCell.self)
    public var identifier: String = "button_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public var title: String?
    public var imageName: String?
    public var action: (UIButton) -> Void

    public init(title: String?, imageName: String? = nil, action:@escaping (UIButton) -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
        cellConfigurator.cellHeight = .defaultCellHeight
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? ButtonCell {
            cell.button.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(cellConfigurator.cellContentEdges)
            }
            cell.selectionStyle = .none

            cell.button.setTitle(title, for: .normal)
            if let imageName = self.imageName {
                cell.button.setImage(UIImage(named: imageName), for: .normal)
            }

            cell.button.addHandler(for: .touchUpInside, handler: action)
        }
    }

}

open class ButtonCell: CommonInitTableCell {

    public lazy var button = UIButton(type: .roundedRect)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
