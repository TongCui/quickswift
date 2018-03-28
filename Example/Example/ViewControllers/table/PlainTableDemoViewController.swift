//
//  PlainTableDemoViewController.swift
//  Example
//
//  Created by tcui on 23/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift


final class PlainTableDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //  Reuse headers
    lazy var adapter = HeadersCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.reloadData()
    }
}
