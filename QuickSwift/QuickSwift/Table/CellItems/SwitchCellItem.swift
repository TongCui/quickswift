//
//  SwitchCellItem.swift
//  QuickSwift
//
//  Created by tcui on 23/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

open class SwitchCellItem: CellItemProtocol {
    public var registerType: TableViewRegisterType = .class(SwitchCell.self)
    public var identifier: String = "switch_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public var title: String
    public var action: (Bool) -> Void
    public var isOn: Bool = false

    public init(title: String, action:@escaping (Bool) -> Void) {
        self.title = title
        self.action = action
        cellConfigurator.cellHeight = .defaultCellHeight
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? SwitchCell {
            cell.selectionStyle = .none
            cell.switchLabel.text = title
            cell.switch.isOn = isOn
            cell.switch.addHandler(for: .valueChanged) { [weak self] (theSwitch: UISwitch) in
                self?.isOn = theSwitch.isOn
                self?.action(theSwitch.isOn)
            }
            let edges = cellConfigurator.cellContentEdges
            cell.switch.snp.updateConstraints { make in
                make.trailing.equalToSuperview().offset(-edges.right)
            }
            cell.switchLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(edges.left)
            }
        }
    }
}

open class SwitchCell: CommonInitTableCell {

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
