//
//  CommonInitTableHeaderFooterView.swift
//  QuickSwift
//
//  Created by tcui on 28/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

open class CommonInitTableHeaderFooterView: UITableViewHeaderFooterView {
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {

    }
}
