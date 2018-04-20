//
//  DemoCellItems.swift
//  Example
//
//  Created by tcui on 18/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

class Demo1CellItem: CellItemProtocol {
    let texts: [String]
    var identifier: String = "cell1"
    var settings = CellSettings()
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func register(tableView: UITableView) {
        tableView.register(CellItem1Cell.typeName.toNib(), forCellReuseIdentifier: identifier)
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = tableCell as? CellItem1Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
        return tableCell
    }
}

class Demo2CellItem: CellItemProtocol {
    let texts: [String]
    var identifier: String = "cell2"
    var settings = CellSettings()
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func register(tableView: UITableView) {
        tableView.register(CellItem1Cell.typeName.toNib(), forCellReuseIdentifier: identifier)
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = tableCell as? CellItem2Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
        return tableCell
    }
}

class Demo3CellItem: CellItemProtocol {
    let texts: [String]
    var identifier: String = "cell3"
    var settings = CellSettings()
    
    init(texts: [String]) {
        self.texts = texts
        add(action: .cellDidSelect) { (params) in
            print("\(texts) did press")
        }
    }
    
    func register(tableView: UITableView) {
        tableView.register(CellItem3Cell.typeName.toNib(), forCellReuseIdentifier: identifier)
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = tableCell as? CellItem3Cell {
            cell.label1.text = texts.first!
            cell.label2.text = texts.last!
        }
        return tableCell
    }
}
