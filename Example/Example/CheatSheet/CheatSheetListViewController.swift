//
//  CheatSheetListViewController.swift
//  Example
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import QuickSwift
import UIKit

final class CheatSheetListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = DefaultTableAdapter(tableView: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let section = PlainSectionItem()
        
        section.append(cellItem(title: "xcrun", segue: .goCheatSheetVC, type: .xcrun))
        
        adapter.append(sectionItem: section)

        adapter.reloadData()
    }
    
    func cellItem(title: String, segue: SegueIds, type: CheatSheetType) -> CellItemProtocol {
        let cellItem = SystemStyleCellItem(style: .default).customUI { (cell) in
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = title
        }
        cellItem.add(action: .cellDidSelect) { [weak self](params) in
            self?.performSegue(for: segue.rawValue) { (vc: CheatSheetViewController) in
                vc.type = type
            }
        }
        
        return cellItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        prepareWithSegueContext(for: segue, sender: sender)
    }
}

