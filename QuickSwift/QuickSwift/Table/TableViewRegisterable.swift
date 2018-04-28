//
//  TableViewRegisterable.swift
//  TableAdapter
//
//  Created by tcui on 26/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public protocol TableViewReuableView: AnyObject {}
extension UITableViewCell: TableViewReuableView {}
extension UITableViewHeaderFooterView: TableViewReuableView {}

/// TableViewRegisterType
///
/// - none: UITableViewCell
/// - nib: func register(UINib?, forCellReuseIdentifier: String)
/// - `class`: func register(AnyClass?, forCellReuseIdentifier: String)
public enum TableViewRegisterType {
    case none
    case nib(UINib)
    case `class`(TableViewReuableView.Type)
}

/// Cell or HeaderFooter which can be registered into a tableview
public protocol TableViewRegisterable: AnyObject {
    var identifier: String { get set }
    var registerType: TableViewRegisterType { get }
}
