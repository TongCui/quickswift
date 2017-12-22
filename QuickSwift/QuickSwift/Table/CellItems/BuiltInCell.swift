//
//  BuiltInCell.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

class BuiltInCell: UITableViewCell, CommonInit {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        if let custom = self as? BuiltInCellCustomizable {
            custom.builtInCellCustomSettings()
        }
    }
}
