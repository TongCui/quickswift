//
//  CellInsertDeleteDemoViewController.swift
//  Example
//
//  Created by tcui on 11/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class CellOperationsAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {
        
        let operationSection = TitleHeaderSectionItem(header: "Operation")
        operationSection.append {
            [
                buttonCellItem(title: "Insert 1", color: .blue) { [unowned self] _ in self.insert(1) },
                buttonCellItem(title: "Delete 1", color: .red) { [unowned self] _ in self.delete(1) },
                buttonCellItem(title: "Insert 10", color: .blue) { [unowned self] _ in self.insert(10) },
                buttonCellItem(title: "Delete 10", color: .red) { [unowned self] _ in self.delete(10) }
            ]
        }
        
        
        let contentSection = TitleHeaderSectionItem(header: "Content")
        contentSection.append {
            [
                OneLineTextCellItem(text: "First Cell"),
                OneLineTextCellItem(text: "last Cell")
            ]
        }
        
        append {
            [
                operationSection,
                contentSection
            ]
        }
    }
    
    func buttonCellItem(title: String, color: UIColor, action: @escaping (UIButton) -> Void ) -> ButtonCellItem {
        return ButtonCellItem(title: title, action: action).uiSettings { (cell) in
            if let cell = cell as? ButtonCell {
                cell.button.setTitleColor(color, for: .normal)
            }
        }
    }
    
    func insert(_ count: Int) {
        
    }
    
    func delete(_ count: Int) {
        
    }
    
    
}

final class CellInsertDeleteDemoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = CellOperationsAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.reloadData()
    }
    
}
