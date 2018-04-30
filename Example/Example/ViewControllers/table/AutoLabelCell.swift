//
//  AutoLabelCell.swift
//  Example
//
//  Created by tcui on 24/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift


final class AutoLabelCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        label1.numberOfLines = 0
        label2.numberOfLines = 2
        label3.numberOfLines = 0
    }
    
}
