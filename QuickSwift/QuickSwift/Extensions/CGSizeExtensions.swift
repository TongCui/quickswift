//
//  CGSizeExtensions.swift
//  QuickSwift
//
//  Created by tcui on 25/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension CGSize {
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}
