//
//  TitleFooter.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

class TitleFooter: SectionHeaderFooterProtocol {

    var title: String?
    var height: CGFloat?
    var identifier: String = "title_footer"

    func register(tableView: UITableView) {
        tableView.register(TitleFooter.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func view(tableView: UITableView, section: Int) -> UIView? {
        return nil
    }

    init(title: String? = nil) {
        self.title = title
    }
}
