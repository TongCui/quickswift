//
//  CellItem.swift
//  TableAdapter
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

/// CellItem Pattern
public protocol CellItemProtocol: TableViewRegisterable, DataSourceElement {
    var cellConfigurator: CellConfigurator { get }
    var actionHandler: CellActionHandler { get }
    var cellDisplayingContext: CellItemDisplayingContext { get }
    func bind(cell: UITableViewCell)
}

public extension CellItemProtocol {
    @discardableResult
    public func customUI(uiSettings: @escaping (UITableViewCell) -> Void) -> Self {
        cellConfigurator.cellCustomUISettings = uiSettings
        return self
    }

    @discardableResult
    public func add(action: CellActionHandler.Actions, handler: @escaping (TableParams) -> Void) -> Self {
        actionHandler.actions[action] = handler
        return self
    }

    public func setNeedsUpdateCellHeight() {
        if let tableView = self.cellDisplayingContext.tableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

/// Handle cell actions, cellDidSelect, cellWillDisplay, etc.
final public class CellActionHandler {
    public enum Actions: Hashable, CustomStringConvertible {
        public var hashValue: Int {return self.description.hashValue }

        public static func ==(lhs: CellActionHandler.Actions, rhs: CellActionHandler.Actions) -> Bool {
            return lhs.description == rhs.description
        }

        case cellDidSelect
        case cellWillDisplay
        case cellDidEndDisplaying
        case custom(String)

        public var description: String {
            switch self {
            case .cellDidSelect:        return "cellDidSelect"
            case .cellWillDisplay:      return "cellWillDisplay"
            case .cellDidEndDisplaying: return "cellDidEndDisplaying"
            case .custom(let key):      return "custom(\(key)"
            }
        }
    }

    var actions: [Actions: (TableParams) -> Void] = [:]

    public func getHandler(for action: Actions) -> ((TableParams) -> Void)? {
        return actions[action]
    }

    public init() {}
}

/// Cell ui-related settings, cell height, seperator style, etc.
final public class CellConfigurator {

    public var cellSeparatorStyle: UITableViewCell.SeparatorLineStyle = .default
    public var cellHeight = CGFloat.automaticDimension
    public var cellContentEdges = UIEdgeInsets(margin: .defaultMargin)
    public var cellCustomUISettings: ((UITableViewCell) -> Void)?

    public func configue(cell: UITableViewCell) {
        cell.setSeparatorLineStyle(cellSeparatorStyle)
        cellCustomUISettings?(cell)
    }

    public var cellContentMargin: CGFloat? {
        get {
            return cellContentEdges.isSameMargin ? cellContentEdges.left : nil
        }
        set {
            cellContentEdges = UIEdgeInsets(margin: newValue ?? .defaultMargin)
        }
    }

    public init() {}
}

final public class CellItemDisplayingContext {
    public weak var cell: UITableViewCell?
    public weak var tableView: UITableView?
    public var indexPath: IndexPath?

    func cell(willDisplay cell: UITableViewCell, tableView: UITableView, indexPath: IndexPath) {
        self.cell = cell
        self.tableView = tableView
        self.indexPath = indexPath
    }

    func cell(didEndDisplaying cell: UITableViewCell, tableView: UITableView, indexPath: IndexPath) {
        self.cell = nil
        self.tableView = nil
        self.indexPath = nil
    }

    public init() {}
}
