//
//  TableSettings.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public class TableParams {
    public var cellItem: CellItemProtocol?
    public var sectionItem: SectionItemProtocol?

    public var indexPath: IndexPath?
    public var cell: UITableViewCell?
    public var tableView: UITableView?

    init(builder: (TableParams) -> Void) {
        builder(self)
    }

    public func viewController<T: UIViewController>() -> T? {
        return tableView?.parentViewController()
    }
}

final public class CellSettings {

    public enum Actions: Hashable, CustomStringConvertible {
        public var hashValue: Int {return self.description.hashValue }

        public static func ==(lhs: CellSettings.Actions, rhs: CellSettings.Actions) -> Bool {
            return lhs.toS() == rhs.toS()
        }

        case cellDidSelect
        case cellWillDisplay
        case cellDidEndDisplaying
        case custom(String)

        public var description: String {
            switch self {
            case .cellDidSelect: return "cellDidSelect"
            case .cellWillDisplay: return "cellWillDisplay"
            case .cellDidEndDisplaying: return "cellDidEndDisplaying"
            case .custom(let key): return key
            }
        }
    }

    weak var tableView: UITableView?
    weak var displayingCell: UITableViewCell?
    var indexPath: IndexPath?

    var cellSeperatorStyle: UITableViewCell.SeparatorLineStyle = .default
    var cellHeight = CGFloat.automaticDimension
    var cellContentEdges = UIEdgeInsets(margin: .defaultMargin)
    var cellUISettings: ((UITableViewCell) -> Void)?
    var actions: [Actions: (TableParams) -> Void] = [:]

    public init() {

    }
}
