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
        
        self.append {
            [
                TitleHeaderSectionItem(header: "tableview").append {
                    [
                        cellItem(title: "SystemDefaultCell", goto: "go_system_cell_vc"),
                        cellItem(title: "OneLineTextCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.oneLineText),
                        cellItem(title: "LoadingCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.loading),
                        cellItem(title: "ButtonCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.button),
                        cellItem(title: "LocalImageCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.localImage),
                        cellItem(title: "SwitchCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.switch),
                        cellItem(title: "PlaceholderCell", goto: "go_builtin_cell_vc", sender: BuiltInCellType.placeholder)
                    ]
                },
                TitleHeaderSectionItem(header: "networking").append {
                    [
                        cellItem(title: "Networking", goto: "go_networking_vc")
                    ]
                }
            ]
        }
    }
    
    func cellItem(title: String, goto segue:String, sender: Any? = nil) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .uiSettings{ (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                if let viewController = params.viewController() as? ExamplesViewController {
                    viewController.performSegue(withIdentifier: segue, sender: sender)
                }
            }
    }
}

final class ExamplesViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = ExamplesAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        if let handler = adapter.delegateHandler as? TableViewDefaultDelegateHandler {
            handler.scrollDelegate = self
        }
        
        super.viewDidLoad()
        adapter.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BuiltInCellViewController, let sender = sender as? BuiltInCellType {
            vc.cellType = sender
        }
    }
    
}
