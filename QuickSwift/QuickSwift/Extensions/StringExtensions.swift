//
//  StringExtensions.swift
//  QuickSwift
//
//  Created by tcui on 13/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public extension String {
    var fileName: String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    var fileExtension: String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
