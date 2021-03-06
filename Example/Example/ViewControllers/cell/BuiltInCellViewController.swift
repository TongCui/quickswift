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
    case option
}

final class BuiltInCellAdapter: HeaderFooterTableAdapter {
    
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
            case .option:
                initOptionCell()
            }
        }
    }
    
    
    let colors: [UIColor] = [.red, .green, .blue, .purple]
    
    func initOneLineTextCell() {
        var strings = [
            "OneLineTextCellItem",
            "short",
            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            ]
        
        strings.append(contentsOf: (1...100).map {"line \($0)"} )
        
        append(section: TitleHeaderSectionItem(header: "OneLineTextCellItem") ) {
            zip(strings, (0..<strings.count)).map { (arg) in
                let (string, idx) = arg
                let cellItem = OneLineTextCellItem(text: string)
                cellItem.cellConfigurator.cellContentEdges = UIEdgeInsets(top: .defaultMargin, left: 10 + idx.toCGF())
                return cellItem
            }
        }
    }
    
    func initLoadingCell() {
        let cellItem1 = LoadingCellItem { print("Trigger loading...") }
        let cellItem2 = LoadingCellItem { print("Trigger loading...") }
        cellItem2.cellConfigurator.cellHeight = 100
        append(section: TitleHeaderSectionItem(header: "LoadingCellItem") ) {
            [
                cellItem1,
                cellItem2
            ]
        }
    }
    
    func initButtonCell() {
        let colorsCount = colors.count
        let margins = (1...50).map { (colors[$0 % colorsCount], $0.toCGF()) }
        
        append(section: TitleHeaderSectionItem(header: "ButtonCellItem") ) {
            margins.map { (color, margin) -> ButtonCellItem in
                let cellItem = ButtonCellItem(title: "Button cell with margin \(margin)") { _ in print("button pressed") }
                    .customUI { (cell) in
                        if let cell = cell as? ButtonCell {
                            cell.button.layer.borderWidth = .defaultBorderWidth
                            cell.button.layer.borderColor = color.cgColor
                            cell.button.setTitleColor(color, for: .normal)
                        }
                    }
                cellItem.cellConfigurator.cellContentEdges = UIEdgeInsets(top: .defaultMargin, left: margin)
                cellItem.cellConfigurator.cellHeight = CGFloat.defaultCellHeight + 2 * margin
                return cellItem
            }
        }
    }
    
    func initLocalImageCell() {
        append(section: TitleHeaderSectionItem(header: "LocalImageCellItem (Ratio Height)") ) {
            [1, 2, 3].map { "shop\($0)"}.map {
                LocalImageCellItem(imageName: $0, imageHeight: .imageRatio)
            }
        }
        
        append(section: TitleHeaderSectionItem(header: "LocalImageCellItem (Fixed Height)") ) {
            [1, 2, 3].map { "shop\($0)"}.map {
                LocalImageCellItem(imageName: $0, imageHeight: .height(300))
            }
        }
    }
    
    func initSwitchCell() {
        append(section: TitleHeaderSectionItem(header: "SwitchCellItem") ) {
            colors.map { color in
                SwitchCellItem(title: "Switch Title") { (isOn) in print("current value is \(isOn)") }.customUI { (cell) in
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
        append(sectionItem: sectionItem)
    }
    
    func initOptionCell() {
        
        var section: SectionItemProtocol
        var cellItems: [CellItemProtocol]
        
        section = TitleHeaderSectionItem(header: "NoIcon + Radio Button + defaultSelection")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section) { print("Option \($0) did select") }
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
        
        
        section = TitleHeaderSectionItem(header: "Icon + Radio Button + defaultSelection")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let image = UIImage(named: "icon_star_full")?.toTemplateImage()
            image?.preferredSize = CGSize(side: 20)
            image?.preferredColor = colors[idx % colors.count]
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section, image: image) { print("Option \($0) did select") }.customUI { (cell) in
                cell.selectionStyle = .none
            }
            
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
        
        
        section = TitleHeaderSectionItem(header: "NoIcon + Radio Button + checkmark(green)")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section, selectionIconType: .checkmark(.green)) { print("Option \($0) did select") }
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
        
        section = TitleHeaderSectionItem(header: "Icon + Radio Button + image")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let image = UIImage(named: "icon_star_full")?.toTemplateImage()
            image?.preferredSize = CGSize(side: 20)
            image?.preferredColor = colors[idx % colors.count]
            let selectionImage = UIImage(named: "icon_checkmark")!
            selectionImage.preferredSize = CGSize(side: 20)
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section, image:image, selectionIconType: .image(selectionImage)) { print("Option \($0) did select") } .customUI { (cell) in
                cell.selectionStyle = .none
            }
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
        
        
        section = TitleHeaderSectionItem(header: "NoIcon + Radio Button + images")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let normalImage = UIImage(named: "icon_option_empty")!.toTemplateImage()
            normalImage.preferredColor = .gray
            normalImage.preferredSize = CGSize(side: 30)
            let selectedImage = UIImage(named: "icon_option_radio")!.toTemplateImage()
            selectedImage.preferredColor = .purple
            selectedImage.preferredSize = CGSize(side: 30)
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section,  selectionIconType: .images(normalImage, selectedImage)) { print("Option \($0) did select") }
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
        
        section = TitleHeaderSectionItem(header: "NoIcon + Group Button + images")
        cellItems = (1..<5).map { idx -> OptionCellItem<Int> in
            let normalImage = UIImage(named: "icon_option_empty")!.toTemplateImage()
            normalImage.preferredColor = .gray
            normalImage.preferredSize = CGSize(side: 30)
            let selectedImage = UIImage(named: "icon_option_group")!.toTemplateImage()
            selectedImage.preferredColor = .purple
            selectedImage.preferredSize = CGSize(side: 30)
            let cellItem = OptionCellItem(key:idx, text: "Option \(idx)", sectionItem: section, isMultiSelectable: true,   selectionIconType: .images(normalImage, selectedImage)) { print("Option \($0) did select") }
            cellItem.isSelected = idx == 1
            return cellItem
        }
        section.append { cellItems }
        append(sectionItem: section)
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
