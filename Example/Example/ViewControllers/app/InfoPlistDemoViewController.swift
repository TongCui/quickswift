//
//  InfoPlistDemoViewController.swift
//  Example
//
//  Created by tcui on 8/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import UIKit
import QuickSwift

final class InfoPlistDemoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = DefaultTableAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.append(section: PlainSectionItem()) {
            InfoPlist.all.map { info in
                SystemStyleCellItem(style: .value1).customUI { (cell) in
                    cell.textLabel?.text = info.rawValue
                    cell.detailTextLabel?.text = info.value
                }
            }
        }
        
        adapter.reloadData()
    }
}
