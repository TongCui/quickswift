//
//  TitleSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class TitleHeaderSectionItem: SectionItemProtocol {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?
    public var cellItems: [CellItemProtocol] = []

    public init(header: String, height: CGFloat? = nil) {
        self.header = TitleHeaderFooter(title: header)
        self.header?.height = height
    }
}
