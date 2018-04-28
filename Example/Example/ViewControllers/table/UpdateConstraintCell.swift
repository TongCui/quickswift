//
//  UpdateConstraintCell.swift
//  Example
//
//  Created by tcui on 25/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class UpdateConstraintCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        label1.numberOfLines = 0
        label2.numberOfLines = 0
        label3.numberOfLines = 0
        contentHeight.constant = 30
    }
    
}
