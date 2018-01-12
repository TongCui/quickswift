//
//  BundleExtensions.swift
//  QuickSwift
//
//  Created by tcui on 12/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension Bundle {
    func image(name: String, type: String? = nil) -> UIImage? {
        guard let path = path(forResource: name, ofType: type) else {
            return nil
        }

        return UIImage(contentsOfFile: path)
    }
}
