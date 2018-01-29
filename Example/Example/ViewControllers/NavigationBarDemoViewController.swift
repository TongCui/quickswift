//
//  NavigationBarDemoViewController.swift
//  Example
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class NavigationBarDemoViewController: LifeCycleManagedViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = LinesAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.append(lines: (1..<30).map{ "\($0)). Line \($0)"})
        adapter.reloadData()
    }
}
