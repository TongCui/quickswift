//
//  BuiltInCellViewController.swift
//  Example
//
//  Created by tcui on 10/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class BuiltInCellAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    var settings: TableSettings = TableSettings()
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    let strings = [
        "OneLineTextCellItem",
        "short",
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "line1\nline2\nline3\nlint4"
    ]
    
    let colors: [UIColor] = [.red, .green, .blue, .purple]
    
    required init() {
        
        append(section: { TitleHeaderSectionItem(header: "OneLineTextCellItem") }) {
            strings.map { OneLineTextCellItem(text: $0)}
        }
        
        append(section: { TitleHeaderSectionItem(header: "LoadingCellItem")}) {
            [
                LoadingCellItem { print("Trigger loading...") },
                LoadingCellItem { print("Trigger loading...") }
                    .updateSettings { $0.cellHeight = 100 }
            ]
        }
        
        append(section: { TitleHeaderSectionItem(header: "OneButtonCellItem")}) {
            [ OneButtonCellItem(title: "The whole cell is a button", action: { _ in print("button pressed")}) ]
        }
        
        append(section: { TitleHeaderSectionItem(header: "SwitchCellItem")}) {
            colors.map { color in
                SwitchCellItem(title: "Switch Title") { (isOn) in print("current value is \(isOn)") }.uiSettings{ (cell) in
                    if let cell = cell as? SwitchCell {
                        cell.switch.onTintColor = color
                    }
                }
            }
        }
    }
    
}


final class BuiltInCellViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = BuiltInCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        adapter.reloadData()
        
    }
    
    
}
