//
//  TitleHeader.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

class TitleHeader: SectionHeaderFooterProtocol {

    var title: String?
    var height: CGFloat?
    var identifier: String = "title_header"

    func register(tableView: UITableView) {
        tableView.register(TitleHeader.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func view(tableView: UITableView, section: Int) -> UIView? {
        return nil
    }

    init(title: String?) {
        self.title = title
    }
}
