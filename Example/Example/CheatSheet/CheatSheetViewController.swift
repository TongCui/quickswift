//
//  CheatSheetViewController.swift
//  Example
//
//  Created by tcui on 19/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import QuickSwift
import UIKit

final class CheatSheetAdapter: DefaultTableAdapter {
    required init() {
        super.init()
        
        let commands = [
            "xcrun simctl io booted screenshot <filename>.png",
            "xcrun simctl io booted recordVideo <filename>.<extension>"
        ]
        
        append(section: {TitleHeaderSectionItem(header: "xcrun")}) {
            commands.map { OneLineTextCellItem(text: $0) }
        }
    }
}

final class CheatSheetViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = CheatSheetAdapter(tableView: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.reloadData()
    }
}

