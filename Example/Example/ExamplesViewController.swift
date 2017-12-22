//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift
import SnapKit



class ExamplesViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            
        }
        
    }
}
