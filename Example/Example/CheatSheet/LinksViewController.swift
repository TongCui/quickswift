//
//  LinksViewController.swift
//  Example
//
//  Created by tcui on 2/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import QuickSwift
import UIKit

final class LinksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = DefaultTableAdapter(tableView: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.append(section: PlainSectionItem()) {
            [
                cellItem(title: "Sketch Frameit Resources", subTitle: "www.sketchappsources.com", link: "https://www.sketchappsources.com/free-source/1155-iphone-app-store-assets-sketch-freebie-resouce.html"),
                cellItem(title: "Fastlane examples", subTitle: "A collection of example fastlane setups https://fastlane.tools", link: "https://github.com/fastlane/examples")
            ]
        }

        adapter.reloadData()
    }
    
    func cellItem(title: String, subTitle:String, link: String) -> CellItemProtocol {
        let cellItem = SystemStyleCellItem(style: .subtitle).customUI { (cell) in
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subTitle
            cell.accessoryType = .disclosureIndicator
        }.add(action: .cellDidSelect) { [weak self] (params) in
            let vc = WebPageViewController.typeName.toViewController(storyboard: "CheatSheet") as! WebPageViewController
            vc.pageTitle = title
            vc.pageUrl = link
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cellItem.cellConfigurator.cellHeight = 60
        return cellItem
    }
}

