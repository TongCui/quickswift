//
//  StateLoadingView.swift
//  Example
//
//  Created by tcui on 27/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class StateLoadingView: UIView {

    var spinner = UIActivityIndicatorView(style: .gray)
    
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
        backgroundColor = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
