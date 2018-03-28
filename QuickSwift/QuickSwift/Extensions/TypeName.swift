//
//  TypeName.swift
//  QuickSwift
//
//  Created by tcui on 26/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public protocol TypeName {
    static var typeName: String { get }
}

// Swift Objects
public extension TypeName {
    static var typeName: String {
        let type = String(describing: self)
        return type
    }
}

extension String: TypeName {
    public static var typeName: String {
        let type = String(describing: self)
        return type
    }
}

// Bridge to Obj-C
extension NSObject: TypeName {
    public class var typeName: String {
        let type = String(describing: self)
        return type
    }
}
