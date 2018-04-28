//
//  DemoHeader.swift
//  Example
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

final class DemoHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
    }
    
}
