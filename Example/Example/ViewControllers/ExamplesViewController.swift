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
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {
        
        self.append {
            [
                TitleHeaderSectionItem(header: "tableview").append {
                    [
                        cellItem(title: "SystemDefaultCell", goto: .goSystemCellVC),
                        cellItem(title: "OneLineTextCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.oneLineText),
                        cellItem(title: "LoadingCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.loading),
                        cellItem(title: "ButtonCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.button),
                        cellItem(title: "LocalImageCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.localImage),
                        cellItem(title: "SwitchCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.switch),
                        cellItem(title: "PlaceholderCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.placeholder),
                        cellItem(title: "OptionCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.option),
                        ]
                },
                TitleHeaderSectionItem(header: "networking").append {
                    [
                        cellItem(title: "Networking", goto: .goNetworkingVC)
                    ]
                },
                TitleHeaderSectionItem(header: "view controller").append {
                    [
                        cellItem(title: "LifeCycle", goto: .goLifecycleVC),
                        cellItem(title: "NavigationBar", goto: .goNavigationBarVC),
                    ]
                }
            ]
        }
    }
    
    func cellItem(title: String, goto segue: SegueIds, sender: Any? = nil) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .uiSettings { (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                if let viewController = params.viewController() as? ExamplesViewController {
                    viewController.performSegue(withIdentifier: segue.rawValue, sender: sender)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BuiltInCellViewController, let sender = sender as? BuiltInCellType {
            vc.cellType = sender
        }
        
        if let vc = segue.destination as? LifeCycleDemoViewController {
            vc.lifeCycleManager
                .addAction(.viewDidLoad) { _ in
                    vc.appendInfo("LifeCycleManager - viewDidLoad")
                }
                .addAction(.viewWillAppear) { (animated) in
                    vc.appendInfo("LifeCycleManager - viewWillAppear - \(animated)")
            }
        }
    }
    
}
