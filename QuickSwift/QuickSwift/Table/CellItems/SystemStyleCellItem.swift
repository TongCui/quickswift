//
//  SystemStyleCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class SystemStyleCellItem: CellItemProtocol {

    public var registerType: TableViewRegisterType
    public var identifier: String
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public init(style: UITableViewCellStyle) {
        self.identifier = "system_style_cell_\(style.rawValue) "

        switch style {
        case .default:      registerType = .class(SystemStyleDefaultCell.self)
        case .value1:       registerType = .class(SystemStyleValue1Cell.self)
        case .value2:       registerType = .class(SystemStyleValue2Cell.self)
        case .subtitle:     registerType = .class(SystemStyleSubTitleCell.self)
        }
        cellConfigurator.cellHeight = .defaultCellHeight
    }

    open func bind(cell: UITableViewCell) {

    }
}

open class SystemStyleDefaultCell: UITableViewCell {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class SystemStyleValue1Cell: UITableViewCell {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class SystemStyleValue2Cell: UITableViewCell {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class SystemStyleSubTitleCell: UITableViewCell {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
