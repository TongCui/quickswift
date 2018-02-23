//
//  LogListViewController.swift
//  QuickSwift
//
//  Created by tcui on 8/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

open class LogListViewController: LifeCycleManagedViewController {

    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        return tableView
    }()

    public lazy var adapter = LinesAdapter(tableView: tableView, sectionItem: PlainSectionItem())

    public var showNumber: Bool = false

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func appendLineCellItem(line: String) {
        adapter.append(line: showNumber ? "\((adapter.sections.last?.cellItems.count ?? 0) + 1)) \(line)" : line)
    }

    open func append(line: String) {
        appendLineCellItem(line: line)
        adapter.reloadData()
    }

    open func append(lines: [String]) {
        lines.forEach { appendLineCellItem(line: $0) }
        adapter.reloadData()
    }
}
