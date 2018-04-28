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

    open lazy var dataSourceProvider: TableDataSourceProvider = BasicDataSourceProvider { [unowned self] in self.sections }
    open lazy var delegateProvider: TableDelegateProvider = BasicTableDelegateProvider { [unowned self] in self.sections }

    public required init() {

    }
}

open class HeaderFooterTableAdapter: TableViewAdapterProtocol {

    open weak var tableView: UITableView?
    open var sections: [SectionItemProtocol] = []

    open lazy var dataSourceProvider: TableDataSourceProvider = HeaderFooterDataSourceProvider { [unowned self] in self.sections }
    open lazy var delegateProvider: TableDelegateProvider = HeaderFooterDelegateHandler { [unowned self] in self.sections }

    public required init() {

    }
}
