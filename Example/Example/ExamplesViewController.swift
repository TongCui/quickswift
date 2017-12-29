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
    var sections: SectionItemCollection = []
    var settings: TableSettings = TableSettings()
    
    lazy var dataSourceHandler: TableViewDataSourceHandler? = {
        return TableViewDataSourceHandler(adapter: self)
    }()
    lazy var delegateHandler: TableViewDelegateHandler? = {
        return TableViewDelegateHandler(adapter: self)
    }()
    
    required init() {
        append(section: PlainSectionItem.self) { [weak self] in
            [
                [
                    OneButtonCellItem(title: "button") {button in
                        print("ok")
                        self?.testAppend()
                    },
                ],
                [
                    OneLineTextCellItem(text: "Section - 0"),
                    OneLineTextCellItem(text: "Section - 0"),
                    LoadingCellItem()
                ],
                [
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    OneLineTextCellItem(text: "This is a OneLineTextCellItem"),
                    LoadingCellItem()
                ],
            ]
        }
    }
    
    func testAppend() {
        sections.first?.append(OneLineTextCellItem(text: "New CellItem"))
        reloadData()
        
    }
}

class ExamplesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let button = UIButton(type: .roundedRect)
    
    lazy var adapter = ExamplesAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        adapter.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        button.sendActions(for: .touchUpInside)
    }
    
    
}
