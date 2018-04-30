//
//  SectionItem.swift
//  TableAdapter
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public protocol SectionHeaderFooterProtocol: TableViewRegisterable {
    var title: String? { get set }
    var height: CGFloat? { get set }
    func render(view: UITableViewHeaderFooterView)
}

public protocol SectionItemProtocol: DataSourceElement {
    var cellItems: [CellItemProtocol] { get set }

    var indexTitle: String? { get set }
    var footer: SectionHeaderFooterProtocol? { get set }
    var header: SectionHeaderFooterProtocol? { get set }
}

public extension SectionItemProtocol {
    public func append(_ cellItem: CellItemProtocol) {
        cellItems.append(cellItem)
    }

    @discardableResult
    public func append(cellItems:() -> [CellItemProtocol]) -> Self {
        self.cellItems.append(contentsOf: cellItems())
        return self
    }

    public func clear() {
        cellItems.removeAll()
    }

    public func setHeaderHeight(_ height: CGFloat?) {
        header?.height = height
    }

    public func setFooterHeight(_ height: CGFloat?) {
        footer?.height = height
    }
}
