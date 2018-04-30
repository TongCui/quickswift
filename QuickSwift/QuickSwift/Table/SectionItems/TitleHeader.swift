//
//  TitleHeader.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

open class TitleHeaderFooter: SectionHeaderFooterProtocol {
    public var registerType: TableViewRegisterType = .none
    public var identifier: String = "title_header"
    public var title: String?
    public var height: CGFloat?

    public init(title: String?) {
        self.title = title
    }

    open func render(view: UITableViewHeaderFooterView) {

    }
}
