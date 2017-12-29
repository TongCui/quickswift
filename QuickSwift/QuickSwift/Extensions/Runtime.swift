//
//  Runtime.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

func getAssociatedObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer, default defaultValue: PropertyType) -> PropertyType {
    guard let value = objc_getAssociatedObject(object, key) as? PropertyType else {
        setAssociatedObject(object, key: key, newValue: defaultValue)
        return defaultValue
    }
    return value
}

func setAssociatedObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer, newValue: PropertyType) {
    objc_setAssociatedObject(object, key, newValue, .OBJC_ASSOCIATION_RETAIN)
}
