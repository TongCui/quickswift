//
//  IntExtensions.swift
//  QuickSwift
//
//  Created by tcui on 8/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Int {

    public func times(body: (Int) -> Void) {
        guard self > 0 else {
            return
        }
        (0..<self).forEach { body($0) }
    }

    public func upto(_ to: Int, body: (Int) -> Void) {
        guard to >= self else {
            return
        }
        (self...to).forEach { body($0) }
    }

    public func downto(_ down: Int, body: (Int) -> Void) {
        guard down <= self else {
            return
        }
        (down...self).reversed().forEach { body($0) }
    }

}
