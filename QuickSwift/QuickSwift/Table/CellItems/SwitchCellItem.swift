//
//  SwitchCellItem.swift
//  QuickSwift
//
//  Created by tcui on 23/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class SwitchCellItem: CellItemProtocol {
    public var title: String
    public var action: (Bool) -> Void
    public var identifier: String = "switch_cell"
    public var settings: CellSettings = CellSettings()
    public var isOn: Bool = false

    public init(title: String, action:@escaping (Bool) -> Void) {
        self.title = title
        self.action = action
        cellHeight = .defaultCellHeight
    }

    public func register(tableView: UITableView) {
        tableView.register(SwitchCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? SwitchCell {
            cell.selectionStyle = .none
            cell.switchLabel.text = title
            cell.switch.isOn = isOn
            cell.switch.addHandler(for: .valueChanged) { [weak self] (theSwitch: UISwitch) in
                self?.isOn = theSwitch.isOn
                self?.action(theSwitch.isOn)
            }
        }

        return tableCell
    }
}

public class SwitchCell: BuiltInCell {

    public lazy var switchLabel = UILabel()
    public lazy var `switch` = UISwitch()
    var margin: CGFloat = 15

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(`switch`)
        contentView.addSubview(switchLabel)

        let margin = self.margin

        `switch`.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-margin)
        }

        switchLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(margin)
            make.trailing.equalTo(`switch`).offset(margin)
        }
    }
}
