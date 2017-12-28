//
//  AssociatedObjectDemo.swift
//  QuickSwiftTests
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation
@testable import QuickSwift

class AssociatedObjectDemo {
    var name = "name"
}

private struct AssociatedObjectDemoKeys {
    static var ageKey: UInt8 = 0
}

extension AssociatedObjectDemo {
    var age: Int {
        get {
            return getAssociatedObject(self, key: &AssociatedObjectDemoKeys.ageKey, default: 0)
        }
        set {
            setAssociatedObject(self, key: &AssociatedObjectDemoKeys.ageKey, newValue: newValue)
        }
    }
}
