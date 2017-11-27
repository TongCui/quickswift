//
//  ArrayExtensions.swift
//  ArrayExtensions
//
//  Created by tcui on 21/11/2017.
//

import Foundation


public extension Array where Element :Numeric {
    public func sum() -> Element {
        return self.reduce(0, +)
    }
}

public extension Array where Element :Numeric {
    public func sum1() -> Element {
        return self.reduce(0, +)
    }
}



