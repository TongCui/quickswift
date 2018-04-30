//
//  CellItemPattern3ViewController.swift
//  Example
//
//  Created by tcui on 17/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class CellItemPattern3ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataSource: [[CellItemProtocol]] = [
        [
            Demo1CellItem(texts: ["line1", "line2"]),
            Demo2CellItem(texts: ["left", "right"]),
            Demo3CellItem(texts: ["line1", "line2"])
        ],
        [
            Demo1CellItem(texts: ["line1", "line2"]),
            Demo2CellItem(texts: ["left", "right"]),
            Demo3CellItem(texts: ["line1", "line2"])
        ]
    ]
    
    
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

extension CellItemPattern3ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[safe: section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = dataSource[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItem.identifier, for: indexPath)
        cellItem.bind(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellItem = dataSource[indexPath.section][indexPath.row]
        let params = TableParams { _ in }
        cellItem.actionHandler.getHandler(for: .cellDidSelect)?(params)
    }
}
