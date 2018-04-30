//
//  AutoDimentionDemoViewController.swift
//  Example
//
//  Created by tcui on 23/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//


import QuickSwift
import UIKit


final class AutoDimentionDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = CGFloat.automaticDimension
        tableView.register(AutoLabelCell.typeName.toNib(), forCellReuseIdentifier: "cell1")
        tableView.register(AutoLabelExCell.typeName.toNib(), forCellReuseIdentifier: "cell2")
        tableView.register(UpdateConstraintCell.typeName.toNib(), forCellReuseIdentifier: "cell3")
        tableView.register(DemoHeader.typeName.toNib(), forHeaderFooterViewReuseIdentifier: "header")
        
    }
}

extension AutoDimentionDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId: String
        
        switch indexPath.section {
        case 0: cellId = "cell1"
        case 1: cellId = "cell2"
        case 2: cellId = "cell3"
        default: cellId = "error"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? AutoLabelCell {
            cell.label1.text = "=====Top====="
            cell.label2.text = "content".repeat(40)
            cell.label3.text = "=====Bottom====="
        }
        
        if let cell = cell as? AutoLabelExCell {
            cell.label1.text = "=====Top====="
            cell.label2.text = "content".repeat(40)
            cell.labelSize.text = cell.label2.text
            cell.label3.text = "=====Bottom====="
        }
        
        if let cell = cell as? UpdateConstraintCell {
            cell.label1.text = "=====Top====="
            cell.label2.text = "content".repeat(40)
            cell.label3.text = "=====Bottom====="
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section.toCGF() + 1) * 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? DemoHeader {
            view.titleLabel.text = "content".repeat(30)
            view.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? AutoLabelCell {
            if cell.label2.numberOfLines == 0 {
                cell.label2.numberOfLines = 2
            } else {
                cell.label2.numberOfLines = 0
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? AutoLabelExCell {
            if cell.labelSize.numberOfLines == 0 {
                cell.labelSize.numberOfLines = 2
            } else {
                cell.labelSize.numberOfLines = 0
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? UpdateConstraintCell {
            if cell.contentHeight.constant == 30 {
                cell.contentHeight.constant = 120
            } else {
                cell.contentHeight.constant = 30
            }
            
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            
        }
    }
}

