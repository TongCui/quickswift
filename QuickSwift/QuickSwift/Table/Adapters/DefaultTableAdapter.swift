//
//  DefaultTableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 11/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

open class DefaultTableAdapter: TableViewAdapterProtocol {

    open weak var tableView: UITableView?
    open var sections: [SectionItemProtocol] = []

    open lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    open lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)

    public required init() {}
}
