//
//  TableSettings.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public class TableParams {
    public var indexPath: IndexPath?
    public var cellItem: CellItemProtocol?
    public var cell: UITableViewCell?
    public var tableView: UITableView?
    public var sender: Any?

    init(builder: (TableParams) -> Void) {
        builder(self)
    }

    public func viewController<T: UIViewController>() -> T? {
        return tableView?.parentViewController()
    }
}

final public class CellSettings {

    public enum Actions: Hashable {
        public var hashValue: Int {return self.toS().hashValue }

        public static func ==(lhs: CellSettings.Actions, rhs: CellSettings.Actions) -> Bool {
            return lhs.toS() == rhs.toS()
        }

        case cellDidSelect
        case cellWillDisplay
        case cellDidEndDisplaying
        case custom(String)

        private func toS() -> String {
            switch self {
            case .cellDidSelect: return "cellDidSelect"
            case .cellWillDisplay: return "cellWillDisplay"
            case .cellDidEndDisplaying: return "cellDidEndDisplaying"
            case .custom(let key): return key
            }
        }
    }

    weak var tableView: UITableView?
    var indexPath: IndexPath?
    public var seperatorHidden = false
    public var cellHeight = UITableViewAutomaticDimension
    var cellUISettings: ((UITableViewCell) -> Void)?
    var actions: [Actions: (TableParams) -> Void] = [:]

    public init() {

    }
}

final public class SectionSettings {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?

    public init() {

    }
}

final public class TableSettings {
    weak var tableView: UITableView?
    weak var viewController: UIViewController?

    public var tableViewDidScrollHandler: ((UITableView) -> Void)?

    var registeredCellIds = [String]()
    var registeredHeaderFooterIds = [String]()

    public init() {

    }
}
