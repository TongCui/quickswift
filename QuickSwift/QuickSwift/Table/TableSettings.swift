//
//  TableSettings.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public struct CellSettings {
    public var seperatorHidden = false
    public var cellHeight = UITableViewAutomaticDimension

    //  Runtime Variables
    public var indexPath: IndexPath?
    public weak var tableView: UITableView?
    public weak var cell: UITableViewCell?
}

public struct SectionSettings {

    public var headerHeight: CGFloat?
    public var footerHeight: CGFloat?
}

public struct TableSettings {
    public var tableViewDidScrollHandler: ((UITableView) -> Void)?
}
