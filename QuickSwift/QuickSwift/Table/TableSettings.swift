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

    public init() {

    }
}

public class SectionSettings {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?

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
