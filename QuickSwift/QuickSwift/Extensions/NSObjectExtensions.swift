//
//  NSObjectExtensions.swift
//  QuickSwift
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self))
    }

    var classNameShort: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
