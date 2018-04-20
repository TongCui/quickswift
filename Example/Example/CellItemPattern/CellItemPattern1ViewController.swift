//
//  CellItemPattern1ViewController.swift
//  Example
//
//  Created by tcui on 17/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

final class CellItemPattern1ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CellItem1Cell", bundle: nil), forCellReuseIdentifier: "cell1")
        tableView.register(UINib(nibName: "CellItem2Cell", bundle: nil), forCellReuseIdentifier: "cell2")
        tableView.register(UINib(nibName: "CellItem3Cell", bundle: nil), forCellReuseIdentifier: "cell3")
    }

}

extension CellItemPattern1ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell\(indexPath.row + 1)"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch indexPath.row {
        case 0:
            if let cell = cell as? CellItem1Cell {
                cell.label1.text = "\(indexPath)) Line 1"
                cell.label2.text = "\(indexPath)) Line 2"
            }
        case 1:
            if let cell = cell as? CellItem2Cell {
                cell.label1.text = "\(indexPath)) Left"
                cell.label2.text = "\(indexPath)) Right"
            }
        case 2:
            if let cell = cell as? CellItem3Cell {
                cell.label1.text = "\(indexPath)) Line 1"
                cell.label2.text = "\(indexPath)) Line 2"
            }
        default:
            print("Error!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("Do \(indexPath) action")
            case 1:
                print("Do \(indexPath) action")
            case 2:
                print("Do \(indexPath) action")
            default:
                print("Error!")
            }
        case 1:
            switch indexPath.row {
            case 0:
                print("Do \(indexPath) action")
            case 1:
                print("Do \(indexPath) action")
            case 2:
                print("Do \(indexPath) action")
            default:
                print("Error!")
            }
        default:
            print("Error!")
        }
    }
}
