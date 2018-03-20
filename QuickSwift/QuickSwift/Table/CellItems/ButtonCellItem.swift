//
//  ButtonCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class ButtonCellItem: CellItemProtocol {
    public var title: String?
    public var imageName: String?
    public var action: (UIButton) -> Void
    public var identifier: String = "button_cell"
    public var settings: CellSettings = CellSettings()

    public init(title: String?, imageName: String? = nil, action:@escaping (UIButton) -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
        cellHeight = .defaultCellHeight
    }

    public func register(tableView: UITableView) {
        tableView.register(ButtonCell.self, forCellReuseIdentifier: identifier)
    }

    open func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? ButtonCell {
            cell.button.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(cellContentEdges)
            }
            cell.selectionStyle = .none

            cell.button.setTitle(title, for: .normal)
            if let imageName = self.imageName {
                cell.button.setImage(UIImage(named: imageName), for: .normal)
            }

            cell.button.addHandler(for: .touchUpInside, handler: action)
        }

        return tableCell
    }
}

open class ButtonCell: BuiltInCell {

    public lazy var button = UIButton(type: .roundedRect)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
