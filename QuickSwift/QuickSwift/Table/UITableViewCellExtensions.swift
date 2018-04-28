//
//  UITableViewCellExtensions.swift
//  QuickSwift
//
//  Created by tcui on 9/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    enum SeparatorLineStyle {
        case `default`
        case none
        case full
        case leftMargin(CGFloat)
        case margins(CGFloat, CGFloat)
    }

    func setSeparatorLineStyle(_ style: SeparatorLineStyle) {
        switch style {
        case .default:
            break
        case .none:
            separatorInset = UIEdgeInsets(top: 0, left: 2000, bottom: 0, right: 0)
        case .full:
            separatorInset = UIEdgeInsets.zero
        case .leftMargin(let left):
            separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
        case .margins(let left, let right):
            separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        }
    }
}
