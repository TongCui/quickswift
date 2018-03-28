//
//  StateEmptyView.swift
//  Example
//
//  Created by tcui on 27/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class StateEmptyView: UIView {
    var contentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentLabel)
        backgroundColor = .white
        contentLabel.backgroundColor = .clear
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.defaultMargin)
            make.trailing.equalToSuperview().offset(-CGFloat.defaultMargin)
        }
    }
}
