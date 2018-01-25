//
//  BuiltInCellViewController.swift
//  Example
//
//  Created by tcui on 10/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift


enum BuiltInCellType {
    case oneLineText
    case loading
    case button
    case localImage
    case `switch`
    case placeholder
}

final class BuiltInCellAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    var settings: TableSettings = TableSettings()
    
    var cellType = BuiltInCellType.oneLineText {
        didSet {
            switch cellType {
            case .oneLineText:
                initOneLineTextCell()
            case .loading:
                initLoadingCell()
            case .button:
                initButtonCell()
            case .localImage:
                initLocalImageCell()
            case .switch:
                initSwitchCell()
            case .placeholder:
                initPlaceholderCell()
            }
        }
    }
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    let colors: [UIColor] = [.red, .green, .blue, .purple]
    
    func initOneLineTextCell() {
        var strings = [
            "OneLineTextCellItem",
            "short",
            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        ]
        
        strings.append(contentsOf: (1...100).map {"line \($0)"} )
        append(section: { TitleHeaderSectionItem(header: "OneLineTextCellItem") }) {
            strings.map { OneLineTextCellItem(text: $0)}
        }
    }
    
    func initLoadingCell() {
        append(section: { TitleHeaderSectionItem(header: "LoadingCellItem")}) {
            [
                LoadingCellItem { print("Trigger loading...") },
                LoadingCellItem { print("Trigger loading...") }
                    .updateSettings { $0.cellHeight = 100 }
            ]
        }
    }
    
    func initButtonCell() {
        let colorsCount = colors.count
        let margins = (1...50).map { (colors[$0 % colorsCount], $0.toCGF()) }
        
        append(section: { TitleHeaderSectionItem(header: "ButtonCellItem")}) {
            margins.map { (color, margin) -> ButtonCellItem in
                let cellItem = ButtonCellItem(title: "Button cell with margin \(margin)", edgeInsets: UIEdgeInsetsMake(margin, margin, margin, margin), action: { _ in print("button pressed")}).uiSettings{ (cell) in
                    if let cell = cell as? ButtonCell {
                        cell.button.layer.borderWidth = .defaultBorderWidth
                        cell.button.layer.borderColor = color.cgColor
                        cell.button.setTitleColor(color, for: .normal)
                    }
                }
                
                cellItem.cellHeight = CGFloat.defaultCellHeight + 2 * margin
                return cellItem
            }
        }
    }
    
    func initLocalImageCell() {
        append(section: { TitleHeaderSectionItem(header: "LocalImageCellItem (Ratio Height)")}) {
            [1, 2, 3].map { "shop\($0)"}.map {
                LocalImageCellItem(imageName: $0, imageHeight: .imageRatio, margin: 10)
            }
        }
        
        append(section: { TitleHeaderSectionItem(header: "LocalImageCellItem (Fixed Height)")}) {
            [1, 2, 3].map { "shop\($0)"}.map {
                LocalImageCellItem(imageName: $0, imageHeight: .height(300), margin: 10)
            }
        }
    }
    
    func initSwitchCell() {
        append(section: { TitleHeaderSectionItem(header: "SwitchCellItem")}) {
            colors.map { color in
                SwitchCellItem(title: "Switch Title") { (isOn) in print("current value is \(isOn)") }.uiSettings{ (cell) in
                    if let cell = cell as? SwitchCell {
                        cell.switch.onTintColor = color
                    }
                }
            }
        }
    }
    
    func initPlaceholderCell() {
        let sectionItem = TitleHeaderSectionItem(header: "PlaceholderCellItem")
        sectionItem.append(PlaceholderCellItem(height: 30))
        sectionItem.append {
            (1...5).map {"line \($0)"}.map { OneLineTextCellItem(text: $0) }
        }
        sectionItem.append(PlaceholderCellItem(height: 100))
        
        append(sectionItem)
    }
    
    required init() {}
    
}


final class BuiltInCellViewController: UIViewController {
    
    var cellType = BuiltInCellType.oneLineText
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = BuiltInCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        adapter.cellType = cellType
        super.viewDidLoad()
        adapter.reloadData()
    }
    
}
