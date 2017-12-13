//
//  IntExtensions.swift
//  QuickSwift
//
//  Created by tcui on 8/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension Int {
    
    public var isEven:Bool { return self % 2 == 0 }
    
    public var isOdd:Bool { return self % 2 != 0 }
    
    public var isPrime: Bool {
        if self == 2 {
            return true
        }
        
        guard self > 1 && self % 2 != 0 else {
            return false
        }
        
        let base = Int(sqrt(Double(self)))
        for i in Swift.stride(from: 3, through: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
    
    public static func primes(first: Int) -> [Int] {
        guard first > 0 else {
            return []
        }
        return Array(PrimeSequence().prefix(first))
    }
    
    public func times(body: (Int) -> Void) {
        guard self > 0 else {
            return
        }
        (0..<self).forEach { body($0) }
    }
}

struct PrimeSequence: Sequence {
    func makeIterator() -> AnyIterator<Int> {
        var number = 1
        
        return AnyIterator {
            repeat {
                number += 1
            } while !number.isPrime
            
            return number
        }
    }
}
