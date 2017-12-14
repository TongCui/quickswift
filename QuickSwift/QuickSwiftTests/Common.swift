//
//  Common.swift
//  QuickSwiftTests
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import XCTest

class TestBundle {

    static func bundle() -> Bundle {
        return Bundle(for: TestBundle.self)
    }

    static func image(name: String, type: String?) -> UIImage? {
        guard let path = bundle().path(forResource: name, ofType: type) else {
            return nil
        }

        return UIImage(contentsOfFile: path)
    }
}
