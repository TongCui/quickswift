//
//  TableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 21/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

public let defaultCellHeight: CGFloat = 44

public protocol DataSourceElement: AnyObject {}

public protocol TableViewRegisterable {
    var identifier: String { get set }
    func register(tableView: UITableView)
}

public extension TableViewRegisterable {
    mutating func updateIdentifier(suffix: String) {
        identifier = "\(identifier)_\(suffix)"
    }
}

public protocol CellItemProtocol: TableViewRegisterable, DataSourceElement {
    var settings: CellSettings { get set }
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    var cellHeight: CGFloat {get set}
    func handler(for action: CellSettings.Actions) -> ((TableParams) -> Void)?
}

public extension CellItemProtocol {
    public var tableView: UITableView? {
        return settings.tableView
    }

    public var indexPath: IndexPath? {
        return settings.indexPath
    }

    public func parentViewController<T: UIViewController>() -> T? {
        return tableView?.parentViewController()
    }

    public var cellHeight: CGFloat {
        get {
            return settings.cellHeight
        }
        set {
            settings.cellHeight = newValue
        }
    }

    public var cellSeparatorStyle: UITableViewCell.SeparatorLineStyle {
        get {
            return settings.cellSeperatorStyle
        }
        set {
            settings.cellSeperatorStyle = newValue
        }
    }

    public var cellContentEdges: UIEdgeInsets {
        get {
            return settings.cellContentEdges
        }
        set {
            settings.cellContentEdges = newValue
        }
    }

    public var cellContentMargin: CGFloat? {
        get {
            guard settings.cellContentEdges.isSameMargin else {
                return nil
            }

            return settings.cellContentEdges.left
        }
        set {
            guard let margin = newValue else {
                settings.cellContentEdges = UIEdgeInsets(margin: .defaultMargin)
                return
            }

            settings.cellContentEdges = UIEdgeInsets(margin: margin)
        }
    }

    public func getDisplayingCell<T: UITableViewCell>() -> T? {
        return settings.displayingCell as? T
    }

    @discardableResult
    public func settings(_ customSettings: (Self) -> Void) -> Self {
        customSettings(self)
        return self
    }

    @discardableResult
    public func uiSettings(customUISettings: @escaping (UITableViewCell) -> Void) -> Self {
        settings.cellUISettings = customUISettings
        return self
    }

    @discardableResult
    public func add(action: CellSettings.Actions, handler: @escaping (TableParams) -> Void) -> Self {
        settings.actions[action] = handler
        return self
    }

    public func handler(for action: CellSettings.Actions) -> ((TableParams) -> Void)? {
        return settings.actions[action]
    }
}

public protocol SectionHeaderFooterProtocol: TableViewRegisterable {
    func view(tableView: UITableView, section: Int) -> UIView?
    var title: String? { get set }
    var height: CGFloat? { get set }
}

public protocol SectionItemProtocol: DataSourceElement {
    var cellItems: [CellItemProtocol] { get set }

    var indexTitle: String? { get set }
    var footer: SectionHeaderFooterProtocol? { get set }
    var header: SectionHeaderFooterProtocol? { get set }
}

public extension SectionItemProtocol {
    @discardableResult
    public func append(cellItems:() -> [CellItemProtocol]) -> Self {
        self.cellItems.append(contentsOf: cellItems())
        return self
    }

    @discardableResult
    public func append(_ cellItem: CellItemProtocol) -> Self {
        cellItems.append(cellItem)
        return self
    }

    public func clear() {
        cellItems.removeAll()
    }

    public func setHeaderHeight(_ height: CGFloat?) {
        header?.height = height
    }

    public func setFooterHeight(_ height: CGFloat?) {
        footer?.height = height
    }
}

public protocol TableViewAdapterProtocol: AnyObject {
    var sections: [SectionItemProtocol] { get set }
    weak var tableView: UITableView? { get set }

    init()
    init(tableView: UITableView)

    var dataSourceHandler: TableDataSourceHandlerProtocol? { get set }
    var delegateHandler: TableDelegateHandlerProtocol? { get set }
}

public extension TableViewAdapterProtocol {

    public func parentViewController<T: UIViewController>() -> T? {
        return tableView?.parentViewController()
    }

    public init(tableView: UITableView) {
        self.init()
        link(tableView: tableView)
    }

    func reloadTableView() {
        tableView?.reloadData()
    }

    public func reloadData() {
        reloadTableView()
    }

    public func clear() {
        sections.removeAll()
        reloadTableView()
    }

    public func link(tableView: UITableView) {
        tableView.dataSource = dataSourceHandler
        tableView.delegate = delegateHandler
        self.tableView = tableView
    }

    public func hidePlainTaleBottomCells() {
        guard let tableView = self.tableView else {
            return
        }

        tableView.tableFooterView = UIView()
    }

    func cellItem(section: Int, row: Int) -> CellItemProtocol? {
        return sections[safe: section]?.cellItems[safe: row]
    }

    func cellItem(indexPath: IndexPath) -> CellItemProtocol? {
        return cellItem(section: indexPath.section, row: indexPath.row)
    }

    func sectionItem(indexPath: IndexPath) -> SectionItemProtocol? {
        return sections[safe: indexPath.section]
    }

    public func cellItem<T>(at indexPath: IndexPath) -> T? {
        return cellItem(indexPath: indexPath) as? T
    }

    public func firstCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.first { $0 is T } as? T
    }

    public func lastCellItem<T>(in section: Int) -> T? {
        return sections[safe: section]?.cellItems.reversed().first { $0 is T } as? T
    }

    @discardableResult
    public func append(sectionItem: SectionItemProtocol) -> Self {
        sections.append(sectionItem)
        return self
    }

    @discardableResult
    public func append<T: SectionItemProtocol>(section: () -> T, cellItems: () -> [CellItemProtocol]) -> Self {
        let section = section()
        section.cellItems.append(contentsOf: cellItems())
        sections.append(section)
        return self
    }

    @discardableResult
    public func append<T: SectionItemProtocol>(section: () -> T, dataSource: () -> [[CellItemProtocol]]) -> Self {

        dataSource().forEach { (cellItems) in
            append(section: section) { cellItems }
        }
        return self
    }

    @discardableResult
    public func append(_ sectionItem: SectionItemProtocol) -> Self {
        sections.append(sectionItem)
        return self
    }

    @discardableResult
    public func append(sectionItems: () -> [SectionItemProtocol]) -> Self {
        sections.append(contentsOf: sectionItems())
        return self
    }

}

/** Animations */
public extension TableViewAdapterProtocol {
    public func append(cellItem: CellItemProtocol, animated: UITableViewRowAnimation = .none) {
        guard let sectionItem = sections.last else {
            return
        }

        sectionItem.append(cellItem)
    }

    public func append(cellItems: [CellItemProtocol], animated: UITableViewRowAnimation = .none) {

    }

    public func insert(cellItem: CellItemProtocol, at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func insert(cellItems: [CellItemProtocol], at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(cellItem: CellItemProtocol, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(cellItems: [CellItemProtocol], animated: UITableViewRowAnimation = .none) {

    }

    public func remove(at indexPath: IndexPath, animated: UITableViewRowAnimation = .none) {

    }

    public func remove(at indexPaths: [IndexPath], animated: UITableViewRowAnimation = .none) {

    }

}

open class DefaultTableAdapter: TableViewAdapterProtocol {

    open weak var tableView: UITableView?
    open var sections: [SectionItemProtocol] = []

    open lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    open lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)

    public required init() {}
}
