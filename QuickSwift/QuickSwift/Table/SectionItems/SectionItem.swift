//
//  SectionItem.swift
//  QuickSwift
//
//  Created by tcui on 23/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class SectionItem: SectionItemProtocol {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?
    public var cellItems: [CellItemProtocol] = []

    convenience public init() {
        self.init(header: nil, footer: nil)
    }

    public init(header: SectionHeaderFooterProtocol?, footer: SectionHeaderFooterProtocol? = nil) {}
}
