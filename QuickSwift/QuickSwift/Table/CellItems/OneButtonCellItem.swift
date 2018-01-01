//
//  OneButtonCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class OneButtonCellItem: CellItemProtocol {
    public var title: String
    public var action: (UIButton) -> Void
    public var identifier: String = "onebutton_cell"
    public var settings: CellSettings = CellSettings()

    public init(title: String, action:@escaping (UIButton) -> Void) {
        self.title = title
        self.action = action
        settings.cellHeight = kDefaultCellHeight * 2
    }

    public func register(tableView: UITableView) {
        tableView.register(OneButtonCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? OneButtonCell {
            cell.selectionStyle = .none
            cell.button.setTitle(title, for: .normal)
            cell.button.addHandler(for: .touchUpInside, handler: action)
        }

        return tableCell
    }
}

public class OneButtonCell: BuiltInCell {

    public lazy var button = UIButton(type: .roundedRect)

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(button)
        let margin: CGFloat = 20
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        }
    }
}
