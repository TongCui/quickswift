//
//  HeadersViewController.swift
//  Example
//
//  Created by tcui on 22/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

import QuickSwift

final class HeadersCellAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {
        let plainHeader = PlainSectionItem()
        plainHeader.append(OneLineTextCellItem(text: "PlainSectionItem"))
        
        let titleHeader = TitleHeaderSectionItem(header: "header")
        titleHeader.setHeaderHeight(.tableHeaderDefaultHeight)
        titleHeader.append(OneLineTextCellItem(text: "TitleHeaderSectionItem"))
        
        let titleHeaderTall = TitleHeaderSectionItem(header: "header", height: 50)
        titleHeaderTall.append(OneLineTextCellItem(text: "TitleHeaderSectionItem 50"))
        
        let titleFooterHeader = TitleHeaderFooterSectionItem(header: "header", footer: "footer")
        titleFooterHeader.setHeaderHeight(.tableHeaderDefaultHeight)
        titleFooterHeader.setFooterHeight(.tableHeaderDefaultHeight)
        titleFooterHeader.append(OneLineTextCellItem(text: "TitleHeaderFooterSectionItem"))
        
        let titleFooterHeaderTall = TitleHeaderFooterSectionItem(header: "header", footer: "footer line 1\nfooter line 2", headerHeight: 50, footerHeight: 50)
        titleFooterHeaderTall.append(OneLineTextCellItem(text: "TitleHeaderFooterSectionItem 50 - 50"))
        
        let titleActionHeader = TitleActionButtonSectionItem(header: "header", actionTitle: "action", height: 50) {
            print("action button did press")
        }
        
        titleActionHeader.append(OneLineTextCellItem(text: "TitleActionButtonSectionItem"))
        
        append {
            [
                plainHeader,
                titleHeader,
                titleHeaderTall,
                titleFooterHeader,
                titleFooterHeaderTall,
                titleActionHeader
            ]
        }
    }
    
    
}

final class HeadersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = HeadersCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        adapter.reloadData()
    }
    
}
