//
//  SystemCellViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class SystemCellAdapter: HeaderFooterTableAdapter {
    required init() {
        super.init()
        let selectionStyles: [(UITableViewCell.SelectionStyle, String)] = [(.none, ".none"), (.blue, ".blue"), (.gray, ".gray"), (.default, ".default")]
        append(section: TitleHeaderSectionItem(header: "Default Cell (SelectionStyle)") ) {
            selectionStyles.map { (style, name) in
                SystemStyleCellItem(style: .default).customUI { (cell) in
                    cell.textLabel?.text = "Default Style (\(name))"
                    cell.selectionStyle = style
                }
            }
        }
        
        let accessoryTypes: [(UITableViewCell.AccessoryType, String)] = [(.none, ".none"), (.disclosureIndicator, ".disclosureIndicator"), (.detailDisclosureButton, ".detailDisclosureButton"), (.checkmark, ".checkmark"), (.detailButton, ".detailButton")]
        append(section: TitleHeaderSectionItem(header: "Default Cell (AccessoryType)") ) {
            accessoryTypes.map { (type, name) in
                SystemStyleCellItem(style: .default).customUI { (cell) in
                    cell.textLabel?.text = "Default Style (\(name))"
                    cell.accessoryType = type
                }
            }
        }
        
        let colors = [(UIColor.red, ".red"), (UIColor.green, ".green"), (UIColor.blue, ".blue")]
        append(section: TitleHeaderSectionItem(header: "Default Cell (BackgroundColor)") ) {
            colors.map { (color, name) in
                SystemStyleCellItem(style: .default).customUI { (cell) in
                    cell.textLabel?.text = "Default Style (\(name))"
                    cell.contentView.backgroundColor = color.withAlphaComponent(0.3)
                }
            }
        }
        
        
        append(section: TitleHeaderSectionItem(header: "Value1 Cell") ) {
            [
                SystemStyleCellItem(style: .value1).customUI { (cell) in
                    cell.textLabel?.text = "Value1 Style(text)"
                    cell.detailTextLabel?.text = "(detail)"
                }
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "Value2 Cell") ) {
            [
                SystemStyleCellItem(style: .value2).customUI { (cell) in
                    cell.textLabel?.text = "Value2 Style(text)"
                    cell.detailTextLabel?.text = "(detail)"
                }
            ]
        }
        
        append(section: TitleHeaderSectionItem(header: "Subtitle Cell") ) {
            [
                SystemStyleCellItem(style: .subtitle).customUI { (cell) in
                    cell.textLabel?.text = "Value2 Style(text)"
                    cell.detailTextLabel?.text = "(detail)"
                }
            ]
        }
    }
    
    
}


final class SystemCellViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    lazy var adapter = SystemCellAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.reloadData()
    }
    
}

