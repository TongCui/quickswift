//
//  TitleHeaderFooter.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

open class TitleHeaderFooter: SectionHeaderFooterProtocol {
    public var registerType: TableViewRegisterType = .none
    public var identifier: String = "title_header_or_footer"
    public var title: String?
    public var height: CGFloat?

    func view(tableView: UITableView, section: Int) -> UIView? {
        return nil
    }

    init(title: String? = nil) {
        self.title = title
    }

    open func render(view: UITableViewHeaderFooterView) {

    }
}
