//
//  TableHandler.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol TableHandlerProtocol {
    var accessor: () -> SectionCollection { get set }
    var sections: SectionCollection { get }
    init()
    init(accessor: @escaping () -> SectionCollection)
}

public extension TableHandlerProtocol {
    public init(accessor: @escaping () -> SectionCollection) {
        self.init()
        self.accessor = accessor
    }
    
    public var sections: SectionCollection {
        return accessor()
    }
}

public class TableViewDataSourceHandler: NSObject, TableHandlerProtocol {
    public var accessor: () -> SectionCollection = {[]}
    
    public required override init() {}
}

extension TableViewDataSourceHandler : UITableViewDataSource {
    
    // MARK: - Configuring a Table View
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellItem = sections[indexPath] else {
            return ErrorCellItem().cell(tableView: tableView, indexPath: indexPath)
        }
        
        return cellItem.cell(tableView: tableView, indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header?.title
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer?.title
    }
    
    // MARK: - Configuring an Index
//    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        guard sections.all else {
//            <#statements#>
//        }
//    }
}

public class TableViewDelegateHandler: NSObject, TableHandlerProtocol {
    public var accessor: () -> SectionCollection = {[]}
    
    public required override init() {}
}

extension TableViewDelegateHandler: UITableViewDelegate {
    
}
