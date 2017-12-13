//
//  Fibonacci.swift
//  QuickSwift
//
//  Created by tcui on 5/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

struct FibonacciSequence: Sequence {
    var startsFromZero: Bool

    init(startsFromZero: Bool) {
        self.startsFromZero = startsFromZero
    }

    func makeIterator() -> AnyIterator<Int> {
        var nextValues = startsFromZero ? (0, 1) : (1, 1)

        return AnyIterator {
            let next = nextValues.0
            nextValues = (nextValues.1, nextValues.0+nextValues.1)
            return next
        }
    }
}

public struct Fibonacci {
    public static func prefix(_ prefix: Int, startsFromZero: Bool = false) -> [Int] {
        return Array(FibonacciSequence(startsFromZero: startsFromZero).prefix(prefix))
    }
}
