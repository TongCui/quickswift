//
//  SwitchCellItem.swift
//  QuickSwift
//
//  Created by tcui on 23/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

open class SwitchCellItem: CellItemProtocol {
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

    open func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? SwitchCell {
            cell.selectionStyle = .none
            cell.switchLabel.text = title
            cell.switch.isOn = isOn
            cell.switch.addHandler(for: .valueChanged) { [weak self] (theSwitch: UISwitch) in
                self?.isOn = theSwitch.isOn
                self?.action(theSwitch.isOn)
            }
            cell.switch.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(-cellContentEdges.right)
            }
            cell.switchLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(cellContentEdges.left)
            }
        }

        return tableCell
    }
}

open class SwitchCell: BuiltInCell {

    public lazy var switchLabel = UILabel()
    public lazy var `switch` = UISwitch()

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(`switch`)
        contentView.addSubview(switchLabel)

        let margin = CGFloat.defaultMargin

        `switch`.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-margin)
        }

        switchLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(margin)
            make.trailing.equalTo(`switch`).offset(margin)
        }
    }
}
