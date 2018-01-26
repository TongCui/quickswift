//
//  PlainSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class PlainSectionItem: SectionItemProtocol {
    public var indexTitle: String?
    public var footer: SectionHeaderFooterProtocol?
    public var header: SectionHeaderFooterProtocol?
    public var cellItems: [CellItemProtocol] = []

    public init() {}

}
