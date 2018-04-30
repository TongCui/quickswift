//
//  StatefulDemoViewController.swift
//  Example
//
//  Created by tcui on 26/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class StatefulDemoAdapter: HeaderFooterTableAdapter {
    required init() {
        super.init()
        
        (1...101).forEach { (idx) in
            append(section: TitleHeaderSectionItem(header: "Demo \(idx)") ) {
                [
                    StatefulCellItem(idx: idx)
                ]
            }
        }
    }
}

final class StatefulDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = StatefulDemoAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.reloadData()
    }


}
