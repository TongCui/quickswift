//
//  CellItemPattern4ViewController.swift
//  Example
//
//  Created by tcui on 17/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift


final class CellItemPattern4Adapter: TableViewAdapterProtocol {
    var sections: [SectionItemProtocol] = []
    var tableView: UITableView?
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    init() {
        2.times { _ in
            append(section: { PlainSectionItem() } ) {
                [
                    Demo1CellItem(texts: ["line1", "line2"]),
                    Demo2CellItem(texts: ["left", "right"]),
                    Demo3CellItem(texts: ["line1", "line2"])
                ]
            }
        }
    }
}


final class CellItemPattern4ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = CellItemPattern4Adapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.reloadData()
    }



}
