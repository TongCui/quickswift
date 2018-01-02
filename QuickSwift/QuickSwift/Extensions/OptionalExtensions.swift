//
//  OptionalExtensions.swift
//  QuickSwift
//
//  Created by tcui on 2/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

extension Optional {
    var isNil: Bool {
        switch self {
        case .none: return true
        case .some(_): return false
        }
    }
}
