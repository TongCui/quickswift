//
//  BuiltInCell.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import SnapKit

public protocol BuiltInCellCustomizable {
    func builtInCellCustomSettings()
}

public class BuiltInCell: UITableViewCell, CommonInit {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public func commonInit() {
        if let custom = self as? BuiltInCellCustomizable {
            custom.builtInCellCustomSettings()
        }
    }
}
