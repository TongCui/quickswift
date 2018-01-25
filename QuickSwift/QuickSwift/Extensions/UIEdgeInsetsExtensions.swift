//
//  UIEdgeInsetsExtensions.swift
//  QuickSwift
//
//  Created by tcui on 25/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension UIEdgeInsets {
    public init(margin: CGFloat) {
        self.init(top: margin, left: margin, bottom: margin, right: margin)
    }

    public init(top: CGFloat, left: CGFloat) {
        self.init(top: top, left: left, bottom: top, right: left)
    }

    public var isSameMargin: Bool {
        return [top, left, bottom, right].uniqued().count == 1
    }
}
