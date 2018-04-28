//
//  TitleHeaderFooterSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public class TitleHeaderFooterSectionItem: SectionItemProtocol {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?
    public var cellItems: [CellItemProtocol] = []

    public init(header: String, footer: String, headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil) {
        self.header = TitleHeaderFooter(title: header)
        self.header?.height = headerHeight
        self.footer = TitleHeaderFooter(title: footer)
        self.footer?.height = footerHeight
    }
}
