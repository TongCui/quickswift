//
//  TitleActionButtonSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 22/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class TitleActionButtonSectionItem: SectionItemProtocol {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?
    public var cellItems: [CellItemProtocol] = []

    public init(header: String, actionTitle: String, height: CGFloat, action: @escaping () -> Void) {
        self.header = TitleActionButtonHeader(title: header, actionTitle: actionTitle, height: height, action: action)
    }
}
