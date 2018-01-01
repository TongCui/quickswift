//
//  TitleHeaderFooterSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public class TitleHeaderFooterSectionItem: SectionItemProtocol {

    public var headerTitle: String {
        get {
            return settings.header?.title ?? ""
        }
        set {
            settings.header?.title = newValue
        }
    }

    public var footerTitle: String {
        get {
            return settings.footer?.title ?? ""
        }
        set {
            settings.footer?.title = newValue
        }
    }

    public var cellItems: [CellItemProtocol] = []

    public var settings: SectionSettings = {
        let settings = SectionSettings()
        settings.header = TitleHeader()
        settings.footer = TitleFooter()
        return settings
    }()

    public required convenience init() {
        self.init(header: "", footer: "")
    }

    public init(header: String, footer: String) {
        self.headerTitle = header
        self.footerTitle = footer
    }
}
