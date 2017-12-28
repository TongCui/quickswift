//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift


class ExamplesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter: TableViewAdapter = {
        let adapter = TableViewAdapter(tableView: tableView)
        adapter.builder = {
            var sectionItem = PlainSectionItem()
            sectionItem.append(OneLineTextCellItem(text: "This is a OneLineTextCellItem"))
            sectionItem.append(OneLineTextCellItem(text: "This is a OneLineTextCellItem"))
            sectionItem.append(OneLineTextCellItem(text: "This is a OneLineTextCellItem"))
            sectionItem.append(OneLineTextCellItem(text: "This is a OneLineTextCellItem"))
            sectionItem.append(LoadingCellItem())
            return [sectionItem]
        }
        return adapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()        
        adapter.reloadData()
    }
}
