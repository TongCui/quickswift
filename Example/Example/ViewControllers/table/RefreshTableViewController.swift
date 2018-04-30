//
//  RefreshTableViewController.swift
//  Example
//
//  Created by tcui on 11/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class RefreshTableAdapter: RefreshableTableAdapter {
    
}


final class RefreshTableDemo1ViewController: LifeCycleManagedViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = RefreshTableAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.append(section: PlainSectionItem()) {
            (0..<10).map { OneLineTextCellItem(text: "Line \($0)") }
        }
        adapter.reloadData()
    }

}

final class RefreshTableDemo2ViewController: LifeCycleManagedViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = RefreshTableAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.append(section: PlainSectionItem()) {
            (0..<10).map { OneLineTextCellItem(text: "Line \($0)") }
        }
        adapter.reloadData()
    }
    
}


