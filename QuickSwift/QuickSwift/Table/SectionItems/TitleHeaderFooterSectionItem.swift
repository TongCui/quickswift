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

    public init(header: String, footer: String) {
        self.header = TitleHeader(title: header)
        self.footer = TitleFooter(title: footer)
    }
}
