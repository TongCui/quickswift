//
//  Swizzle.swift
//  QuickSwift
//
//  Created by tcui on 18/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import ObjectiveC

// MARK: - Use it carefully
public struct Swizzle {

    public static func swizzleInstanceMethods(forClass klass: AnyClass, _ orig: Selector, _ alter: Selector) {
        swizzleClassMethods(forClass: klass, orig, class_getInstanceMethod(klass, orig), alter, class_getInstanceMethod(klass, alter))
    }

    public static func swizzleClassMethods(forClass klass: AnyClass, _ orig: Selector, _ alter: Selector) {
        guard let klass = object_getClass(klass) else { return }
        swizzleClassMethods(forClass: klass, orig, class_getClassMethod(klass, orig), alter, class_getClassMethod(klass, alter))
    }

    private static func swizzleClassMethods(forClass klass: AnyClass, _ orig: Selector, _ origMethod: Method?, _ alter: Selector, _ aleterMethod: Method?) {
        guard let origMethod = origMethod, let aleterMethod = aleterMethod else { return  }

        if class_addMethod(klass, alter, method_getImplementation(origMethod), method_getTypeEncoding(origMethod)) {
            class_replaceMethod(klass, orig, method_getImplementation(aleterMethod), method_getTypeEncoding(aleterMethod))
        } else {
            method_exchangeImplementations(origMethod, aleterMethod)
        }
    }

}
