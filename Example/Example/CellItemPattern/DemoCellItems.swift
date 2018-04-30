//
//  DemoCellItems.swift
//  Example
//
//  Created by tcui on 18/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

class Demo1CellItem: CellItemProtocol {
    var registerType: TableViewRegisterType = .nib(CellItem1Cell.typeName.toNib())
    var identifier: String = "cell1"
    var cellConfigurator = CellConfigurator()
    var actionHandler = CellActionHandler()
    var cellDisplayingContext = CellItemDisplayingContext()
    
    let texts: [String]
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func bind(cell: UITableViewCell) {
        if let cell = cell as? CellItem1Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
    }
}

class Demo2CellItem: CellItemProtocol {
    var registerType: TableViewRegisterType = .nib(CellItem2Cell.typeName.toNib())
    var identifier: String = "cell2"
    var cellConfigurator = CellConfigurator()
    var actionHandler = CellActionHandler()
    var cellDisplayingContext = CellItemDisplayingContext()
    
    let texts: [String]
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func bind(cell: UITableViewCell) {
        if let cell = cell as? CellItem2Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
    }
}

class Demo3CellItem: CellItemProtocol {
    var registerType: TableViewRegisterType = .nib(CellItem3Cell.typeName.toNib())
    var identifier: String = "cell3"
    var cellConfigurator = CellConfigurator()
    var actionHandler = CellActionHandler()
    var cellDisplayingContext = CellItemDisplayingContext()

    let texts: [String]
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func bind(cell: UITableViewCell) {
        if let cell = cell as? CellItem3Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
    }
}
