//
//  Regex.swift
//  QuickSwift
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public class Regex {
    let internalExpression: NSRegularExpression

    public init(_ pattern: String, caseInsensitive: Bool = true) throws {
        self.internalExpression = try NSRegularExpression(pattern: pattern, options: caseInsensitive ? .caseInsensitive : [])
    }

    public func match(input: String) -> Bool {
        let matches = internalExpression.matches(in: input, options: [], range: NSMakeRange(0, input.count))
        return matches.count > 0
    }
}

public extension String {
    public func toR() throws -> Regex { return try Regex(self, caseInsensitive: true) }
    public func toRi() throws -> Regex { return try Regex(self, caseInsensitive: false) }
}

infix operator =~ : ComparisonPrecedence
infix operator !~ : ComparisonPrecedence

public func =~ (input: String, pattern: String) -> Bool {
    do {
        return try Regex(pattern).match(input: input)
    } catch {
        return false
    }
}

public func !~ (input: String, pattern: String) -> Bool {
    do {
        return try !Regex(pattern).match(input: input)
    } catch {
        return true
    }
}
