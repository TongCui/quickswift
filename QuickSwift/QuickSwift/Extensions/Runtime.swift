//
//  Runtime.swift
//  QuickSwift
//
//  Created by tcui on 28/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

final class PropertyWrapper<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

func getAssociatedObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer, default defaultValue: PropertyType) -> PropertyType {
    guard let wrapper = objc_getAssociatedObject(object, key) as? PropertyWrapper<PropertyType> else {
        setAssociatedObject(object, key: key, newValue: PropertyWrapper(defaultValue))
        return defaultValue
    }
    return wrapper.value
}

func setAssociatedObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer, newValue: PropertyType) {
    objc_setAssociatedObject(object, key, PropertyWrapper(newValue), .OBJC_ASSOCIATION_RETAIN)
}

func getAssociatedOptionalObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer) -> PropertyType? {
    guard let wrapper = objc_getAssociatedObject(object, key) as? PropertyWrapper<PropertyType> else {
        return nil
    }
    return wrapper.value
}

func setAssociatedOptionalObject<ObjectType, PropertyType>(_ object: ObjectType, key: UnsafeRawPointer, newValue: PropertyType?) {
    if let newValue = newValue {
        objc_setAssociatedObject(object, key, PropertyWrapper(newValue), .OBJC_ASSOCIATION_RETAIN)
    } else {
        objc_setAssociatedObject(object, key, nil, .OBJC_ASSOCIATION_RETAIN)
    }

}
