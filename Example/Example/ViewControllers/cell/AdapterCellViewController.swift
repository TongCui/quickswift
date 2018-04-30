//
//  AdapterCellViewController.swift
//  Example
//
//  Created by tcui on 27/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class AdapterCellAdapter: HeaderFooterTableAdapter {
    final class ContentAdapter: DefaultTableAdapter {
        var parent: TableViewAdapterProtocol?
        
        required init() {}
        convenience init(count: Int, parent: TableViewAdapterProtocol) {
            self.init()
            self.parent = parent
            
            let section = PlainSectionItem()
            section.setHeaderHeight(.tableZero)
            section.setFooterHeight(.tableZero)
            section.append { (1...count).map { OneLineTextCellItem(text: "Line \($0)")} }
            
            let addMoreCellItem = ButtonCellItem(title: "Add One More Cell") { [weak self] (button) in
                let row = section.cellItems.count - 1
                section.cellItems.insert(OneLineTextCellItem(text: "New Cell"), at: row)
                //  TODO : Update
                self?.reloadData()
                self?.parent?.reloadData()
            }
            addMoreCellItem.cellConfigurator.cellSeparatorStyle = .none
            
            section.append(addMoreCellItem)
            
            append(sectionItem: section)
        }
    }
    
    required init() {
        super.init()
        (1...10).forEach { idx in
            append(section: TitleHeaderSectionItem(header: "Table Section \(idx)") ) {
                [
                    TableAdapterCellItem(adapter: ContentAdapter(count: idx, parent: self))
                ]
            }
        }
    }
    
}


final class AdapterCellViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = AdapterCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.reloadData()
    }
}
