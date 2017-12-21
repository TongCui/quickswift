//
//  UserDefaultsExtensions.swift
//  QuickSwift
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension UserDefaults {

    public subscript<T>(key: String) -> T? {
        get {
            return object(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }

}
