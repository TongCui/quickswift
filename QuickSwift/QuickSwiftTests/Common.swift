//
//  Common.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest

extension Bundle {
    class var test: Bundle { return Bundle(for: Common.self) }
}

class Common {}
