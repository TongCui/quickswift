//
//  CellItemPattern5ViewController.swift
//  Example
//
//  Created by tcui on 18/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class CellItemPattern5ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = DefaultTableAdapter(tableView: tableView)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        2.times { _ in
            adapter.append(section: PlainSectionItem() ) {
                [
                    Demo1CellItem(texts: ["line1", "line2"]),
                    Demo2CellItem(texts: ["left", "right"]),
                    Demo3CellItem(texts: ["line1", "line2"])
                ]
            }
        }
        
        adapter.reloadData()
    }
    
}
