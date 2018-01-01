//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

class ExamplesAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    var settings: TableSettings = TableSettings()
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {
        let headerSection = TitleHeaderSectionItem(header: "Title section")
        headerSection.cellItems.append(OneLineTextCellItem(text: "Title Section Cell Item"))
        sections.append(headerSection)
        
        let headerFooterSection = TitleHeaderFooterSectionItem(header: "Header", footer: "Footer")
        headerFooterSection.cellItems.append(OneLineTextCellItem(text: "Header Footer Section Cell Item"))
        sections.append(headerFooterSection)
        
        append(section: PlainSectionItem.self) { [weak self] in
            [
                [
                    OneButtonCellItem(title: "button") {button in
                        print("ok")
                        self?.testAppend()
                    },
                ],
                [
                    OneLineTextCellItem(text: "Section - 1 - 0").add(action: .cellDidSelect){ (tableParams) in
                        let tableView = tableParams.tableView
                        print(tableView ?? "TableView is nil")
                    },
                    OneLineTextCellItem(text: "Section - 1 - 1").add(action: .cellDidSelect) {params in
                        
                        print("Section - 1 - 1 did press")
                    },
                    LoadingCellItem()
                ],
                [
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem\nLine2\nLine3\nLine4"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    LoadingCellItem()
                ],
                ]
        }
    }
    
    func testAppend() {
        sections.first?.cellItems.append(OneLineTextCellItem(text: "New CellItem"))
        reloadData()
        
    }
}

class ExamplesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = ExamplesAdapter(tableView: tableView, viewController: self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        adapter.reloadData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cellItem: OneLineTextCellItem = adapter.firstCellItem(in: 0) {
            cellItem.add(action: .cellDidSelect) { [weak self] (params) in
                self?.testAction()
            }
        }
    }
    
    func testAction() {
        print("hello world")
    }
    
    
}
