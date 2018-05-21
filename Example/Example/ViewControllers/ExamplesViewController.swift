//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class ExamplesAdapter: HeaderFooterTableAdapter {
    
    required init() {
        super.init()
        
        append(section: TitleHeaderSectionItem(header: "tableview")) { [unowned self] in
            [
                self.cellItem(title: "SystemDefaultCell", goto: .goSystemCellVC),
                self.cellItem(title: "OneLineTextCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.oneLineText),
                self.cellItem(title: "LoadingCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.loading),
                self.cellItem(title: "ButtonCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.button),
                self.cellItem(title: "LocalImageCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.localImage),
                self.cellItem(title: "SwitchCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.switch),
                self.cellItem(title: "PlaceholderCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.placeholder),
                self.cellItem(title: "OptionCell", goto: .goBuiltinCellVC, sender: BuiltInCellType.option),
                self.cellItem(title: "AdapterCell", goto: .goAdapterVC),
                self.cellItem(title: "Insert & Delete", goto: .goCellInsertDeleteVC)
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "tableview")) { [unowned self] in
            [
                self.cellItem(title: "Headers", goto: HeadersViewController.typeName, storyboard: "TableDemos"),
                self.cellItem(title: "Plain Sections", goto: PlainTableDemoViewController.typeName, storyboard: "TableDemos"),
                self.cellItem(title: "Hide bottom cells", goto: PlainTableHideBottomCellsViewController.typeName, storyboard: "TableDemos"),
                self.cellItem(title: "Auto Dimention", goto: AutoDimentionDemoViewController.typeName, storyboard: "TableDemos")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "cellitem pattern revolution")) { [unowned self] in
            [
                self.cellItem(title: "UIKit", goto: CellItemPattern1ViewController.typeName, storyboard: "CellItemPattern"),
                self.cellItem(title: "Datasource", goto: CellItemPattern2ViewController.typeName, storyboard: "CellItemPattern"),
                self.cellItem(title: "CellItem", goto: CellItemPattern3ViewController.typeName, storyboard: "CellItemPattern"),
                self.cellItem(title: "CellItem & Custom Adapter", goto: CellItemPattern4ViewController.typeName, storyboard: "CellItemPattern"),
                self.cellItem(title: "CellItem & Default Adapter", goto: CellItemPattern5ViewController.typeName, storyboard: "CellItemPattern")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "networking")) { [unowned self] in
            [
                self.cellItem(title: "Networking", goto: NetworkingViewController.typeName, storyboard: "NetworkingDemos"),
                self.cellItem(title: "IPAddressDemo", goto: IPAddressDemoViewController.typeName, storyboard: "NetworkingDemos")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "view controller")) { [unowned self] in
            [
                self.cellItem(title: "LifeCycle", goto: LifeCycleDemoViewController.typeName, storyboard: "VCDemos"),
                self.cellItem(title: "NavigationBar1", goto: NavigationBarDemo1ViewController.typeName, storyboard: "VCDemos"),
                self.cellItem(title: "NavigationBar2", goto: NavigationBarDemo2ViewController.typeName, storyboard: "VCDemos"),
                self.cellItem(title: "NavigationBar Search", goto: NavigationBarSearchViewController.typeName, storyboard: "VCDemos"),
                self.cellItem(title: "Segue Demo", goto: SegueDemoViewController.typeName, storyboard: "VCDemos"),
                self.cellItem(title: "Tap Action Demo", goto: TapActionDemoViewController.typeName, storyboard: "VCDemos")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "UI")) { [unowned self] in
            [
                self.cellItem(title: "UIFontTextStyles", goto: FontTextStylesViewController.typeName, storyboard: "UIDemos"),
                self.cellItem(title: "StatefulView", goto: StatefulDemoViewController.typeName, storyboard: "UIDemos")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "Application")) { [unowned self] in
            [
                self.cellItem(title: "Info plist", goto: InfoPlistDemoViewController.typeName, storyboard: "AppDemos")
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "CheatSheet")) { [unowned self] in
            [
                self.cellItem(title: "Cheat Sheet", goto: CheatSheetListViewController.typeName, storyboard: "CheatSheet"),
                self.cellItem(title: "Nice Links", goto: LinksViewController.typeName, storyboard: "CheatSheet"),
            ]
        }
        
    }
    
    func cellItem(title: String, goto vc: String, storyboard: String) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .customUI { (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                
                let nextVC = vc.toViewController(storyboard: storyboard)
                params.tableView?.parentViewController()?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func cellItem(title: String, goto segue: SegueIds, sender: Any? = nil) -> OneLineTextCellItem {
        return OneLineTextCellItem(text: title)
            .customUI { (cell) in
                cell.accessoryType = .disclosureIndicator
            }
            .add(action: .cellDidSelect) { params in
                params.tableView?.parentViewController()?.performSegue(withIdentifier: segue.rawValue, sender: sender)
        }
    }
    
}

final class ExamplesViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = ExamplesAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
