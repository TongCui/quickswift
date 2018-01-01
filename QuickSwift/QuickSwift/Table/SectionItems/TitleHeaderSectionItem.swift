//
//  TitleSectionItem.swift
//  QuickSwift
//
//  Created by tcui on 1/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class TitleHeaderSectionItem: SectionItemProtocol {

    public var headerTitle: String {
        get {
            return settings.header?.title ?? ""
        }
        set {
            settings.header?.title = newValue
        }
    }

    public var cellItems: [CellItemProtocol] = []

    public var settings: SectionSettings = {
       let settings = SectionSettings()
        settings.header = TitleHeader()
        return settings
    }()

    public required convenience init() {
        self.init(header: "")
    }

    public init(header: String) {
        self.headerTitle = header
    }
}
