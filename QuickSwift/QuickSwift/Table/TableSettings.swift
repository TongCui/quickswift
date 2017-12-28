//
//  TableSettings.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public class CellSettings {
    
    public var seperatorHidden = false
    public var cellHeight = UITableViewAutomaticDimension

    //  Runtime Variables
    public var indexPath: IndexPath?
    public weak var tableView: UITableView?
    public weak var cell: UITableViewCell?
    
    public init() {
        
    }
}

public class SectionSettings {
    public init() {
        
    }
}

public class TableSettings {
    
    public var tableViewDidScrollHandler: ((UITableView) -> Void)?
    
    public var registeredCellIds = [String]()
    public var registeredHeaderFooterIds = [String]()
    
    public init() {
        
    }
}
