//
//  StateFailView.swift
//  Example
//
//  Created by tcui on 27/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class StateFailView: UIView {
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    
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
        addSubview(titleLabel)
        addSubview(detailLabel)
        backgroundColor = .white
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        detailLabel.uiStyle.same(with: titleLabel).ui { (label) in
            label.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize - 2)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-2)
            make.leading.equalToSuperview().offset(CGFloat.defaultMargin)
            make.trailing.equalToSuperview().offset(-CGFloat.defaultMargin)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(2)
            make.leading.equalToSuperview().offset(CGFloat.defaultMargin)
            make.trailing.equalToSuperview().offset(-CGFloat.defaultMargin)
        }
    }
}
