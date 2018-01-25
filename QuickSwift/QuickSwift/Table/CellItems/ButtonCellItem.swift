//
//  ButtonCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class ButtonCellItem: CellItemProtocol {
    public var title: String
    public var action: (UIButton) -> Void
    private let edgeInsets: UIEdgeInsets
    public var identifier: String = "button_cell"
    public var settings: CellSettings = CellSettings()

    public init(title: String, edgeInsets: UIEdgeInsets = UIEdgeInsets.zero, action:@escaping (UIButton) -> Void) {
        self.title = title
        self.action = action
        self.edgeInsets = edgeInsets
        cellHeight = .defaultCellHeight
    }

    public func register(tableView: UITableView) {
        tableView.register(ButtonCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? ButtonCell {
            cell.button.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(edgeInsets)
            }
            cell.selectionStyle = .none
            cell.button.setTitle(title, for: .normal)
            cell.button.addHandler(for: .touchUpInside, handler: action)
        }

        return tableCell
    }
}

public class ButtonCell: BuiltInCell {

    public lazy var button = UIButton(type: .roundedRect)

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
