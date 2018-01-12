//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class ExamplesAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    var settings: TableSettings = TableSettings()
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {
        let tableSection = TitleHeaderSectionItem(header: "tableview").append {
            [
                cellItem(title: "SystemDefaultCell", goto: "go_system_cell_vc"),
                cellItem(title: "BuiltInCell", goto: "go_builtin_cell_vc")
            ]
        }
    
        self.append(tableSection)
    }
    
    func cellItem(title: String, goto segue:String) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .uiSettings{ (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                if let viewController = params.viewController() as? ExamplesViewController {
                    viewController.performSegue(withIdentifier: segue, sender: nil)
                }
            }
    }
}

final class ExamplesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = ExamplesAdapter(tableView: tableView, viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
