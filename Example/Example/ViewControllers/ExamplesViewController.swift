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
                        cellItem(title: "AdapterCell", goto: .goAdapterVC),
                        cellItem(title: "Insert & Delete", goto: .goCellInsertDeleteVC)
                        
                    ]
                },
                TitleHeaderSectionItem(header: "tableview").append {
                    [
                        cellItem(title: "Headers", goto: HeadersViewController.typeName, storyboard: "TableDemos"),
                        cellItem(title: "Plain Sections", goto: PlainTableDemoViewController.typeName, storyboard: "TableDemos"),
                        cellItem(title: "Hide bottom cells", goto: PlainTableHideBottomCellsViewController.typeName, storyboard: "TableDemos")
                    ]
                },
                TitleHeaderSectionItem(header: "cellitem pattern revolution").append {
                    [
                        cellItem(title: "UIKit", goto: CellItemPattern1ViewController.typeName, storyboard: "CellItemPattern"),
                        cellItem(title: "Datasource", goto: CellItemPattern2ViewController.typeName, storyboard: "CellItemPattern"),
                        cellItem(title: "CellItem", goto: CellItemPattern3ViewController.typeName, storyboard: "CellItemPattern"),
                        cellItem(title: "CellItem & Custom Adapter", goto: CellItemPattern4ViewController.typeName, storyboard: "CellItemPattern"),
                        cellItem(title: "CellItem & Default Adapter", goto: CellItemPattern5ViewController.typeName, storyboard: "CellItemPattern")
                    ]
                },
                TitleHeaderSectionItem(header: "networking").append {
                    [
                        cellItem(title: "Networking", goto: NetworkingViewController.typeName, storyboard: "NetworkingDemos"),
                        cellItem(title: "IPAddressDemo", goto: IPAddressDemoViewController.typeName, storyboard: "NetworkingDemos")
                    ]
                },
                TitleHeaderSectionItem(header: "view controller").append {
                    [
                        cellItem(title: "LifeCycle", goto: LifeCycleDemoViewController.typeName, storyboard: "VCDemos"),
                        cellItem(title: "NavigationBar1", goto: NavigationBarDemo1ViewController.typeName, storyboard: "VCDemos"),
                        cellItem(title: "NavigationBar2", goto: NavigationBarDemo2ViewController.typeName, storyboard: "VCDemos"),
                        cellItem(title: "NavigationBar Search", goto: NavigationBarSearchViewController.typeName, storyboard: "VCDemos"),
                        cellItem(title: "Segue Demo", goto: SegueDemoViewController.typeName, storyboard: "VCDemos"),
                        cellItem(title: "Tap Action Demo", goto: TapActionDemoViewController.typeName, storyboard: "VCDemos")
                    ]
                },
                TitleHeaderSectionItem(header: "UI").append {
                    [
                        cellItem(title: "UIFontTextStyles", goto: FontTextStylesViewController.typeName, storyboard: "UIDemos"),
                        cellItem(title: "StatefulView", goto: StatefulDemoViewController.typeName, storyboard: "UIDemos")
                    ]
                },
                TitleHeaderSectionItem(header: "Application").append {
                    [
                        cellItem(title: "Info plist", goto: InfoPlistDemoViewController.typeName, storyboard: "AppDemos"),
                    ]
                },
                TitleHeaderSectionItem(header: "CheatSheet").append {
                    [
                        cellItem(title: "Cheat Sheet", goto: CheatSheetViewController.typeName, storyboard: "CheatSheet"),
                        ]
                }
            ]
        }
    }
    
    func cellItem(title: String, goto vc: String, storyboard: String) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .uiSettings { (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                
                let nextVC = vc.toViewController(storyboard: storyboard)
                params.viewController()?.navigationController?.pushViewController(nextVC, animated: true)
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
            vc.showNumber = true
            vc.lifeCycleManager
                .addAction(.viewDidLoad) { _ in
                    vc.append(line: "LifeCycleManager - viewDidLoad")
                }
                .addAction(.viewWillAppear) { animated in
                    if let animated = animated as? Bool {
                        vc.append(line: "LifeCycleManager - viewWillAppear (action1) - \(animated)")
                    }
                }
                .addAction(.viewWillAppear) { animated in
                    if let animated = animated as? Bool {
                        vc.append(line: "LifeCycleManager - viewWillAppear (action2)- \(animated)")
                    }
            }
        }
    }
    
}
