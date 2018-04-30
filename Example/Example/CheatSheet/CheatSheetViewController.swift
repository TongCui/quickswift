//
//  CheatSheetViewController.swift
//  Example
//
//  Created by tcui on 19/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import QuickSwift
import UIKit

enum CheatSheetType: String {
    case xcrun
}

struct CheatSheetTip {
    let comment: String
    let command: String
    
    init(_ command: String, comment: String) {
        self.command = command
        self.comment = comment
    }
    
    func attributedText() -> NSAttributedString {
        let text = "\(comment)\n\(command)"
        let res = NSMutableAttributedString(string: text, attributes: nil)
        
        res.addAttributes([.foregroundColor: UIColor.lightGray], range: NSRange(location: 0, length: comment.count))
        return res.copy() as! NSAttributedString
    }
}



final class CheatSheetAdapter: HeaderFooterTableAdapter {
    
    func setType(_ type: CheatSheetType) {
        switch type {
        case .xcrun:    xcrun()
        }
    }
    
    func xcrun() {
        let commands = [
            CheatSheetTip("$ xcrun simctl list", comment: "Listing all available simulators"),
            CheatSheetTip("$ xcrun simctl create My-iphone7 ", comment: "CRUD - Create"),
            CheatSheetTip("$ xcrun simctl [shutdown|erase|simctl] C8C050F3–062D-4444-A888-BBEC783E31BD ", comment: "CRUD - Shutdown/Erase/Boot"),
            CheatSheetTip("$ xcrun simctl addmedia booted ~/Desktop/[shashi.png|xxx.gif|xxx.mp4] ", comment: "Add Photo/Video to Simulator"),
            CheatSheetTip("$ xcrun simctl [install|uninstall] booted <path>/xx.app ", comment: "Install/Uninstall app inside Simulator"),
            CheatSheetTip("$ xcrun simctl [launch|terminate] booted test.CLI ", comment: "Launch/Terminator app inside Simulator"),
            CheatSheetTip("$ xcrun simctl io booted screenshot <filename>.png", comment: "Take screenshot"),
            CheatSheetTip("$ xcrun simctl io booted recordVideo <filename>.<extension>", comment: "Record video"),
            CheatSheetTip("$ xcrun simctl spawn booted log stream — level=debug", comment: "Collecting Simulator Logs"),
            CheatSheetTip("$ xcrun simctl spawn booted log stream — predicate ‘processImagePath endswith “CLI”’", comment: "Filter log output"),
            CheatSheetTip("$ xcrun simctl spawn booted log stream — predicate ‘eventMessage contains “error” and messageType == info’", comment: "Filter log output"),
            CheatSheetTip("$ xcrun simctl spawn booted log collect", comment: "collect log data"),
            CheatSheetTip("$ cd `xcrun simctl getenv booted SIMULATOR_SHARED_RESOURCES_DIRECTORY`", comment: "open location i"),
            CheatSheetTip("$ xcrun simctl erase all", comment: "Erase all Simulators"),
            CheatSheetTip("$ xcrun simctl list | awk -F “[()]” ‘{ for (i=2; i<NF; i+=2) print $i }’ | grep ‘^[-A-Z0–9]*$’ | xargs -I uuid xcrun simctl delete uuid", comment: "Delete all the Simulators")
        ]
        
        append(section: TitleHeaderSectionItem(header: "xcrun") ) {
            commands.map { OneLineAttributedTextCellItem(attributedText: $0.attributedText()) }
        }
    }
}



final class CheatSheetViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = CheatSheetAdapter(tableView: tableView)
    var type: CheatSheetType!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = type.rawValue.uppercased()
        adapter.setType(type)
        adapter.reloadData()
    }
}

