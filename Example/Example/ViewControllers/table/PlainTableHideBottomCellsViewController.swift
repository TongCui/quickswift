//
//  PlainTableHideBottomCellsViewController.swift
//  Example
//
//  Created by tcui on 28/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class PlainTableHideBottomCellsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //  Reuse headers
    lazy var adapter = DefaultTableAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.append(section: {PlainSectionItem()}) {
            (0...5).map { OneLineTextCellItem(text: "Line \($0)") }
        }
        
        adapter.hidePlainTaleBottomCells()
        
        adapter.reloadData()
    }

}
