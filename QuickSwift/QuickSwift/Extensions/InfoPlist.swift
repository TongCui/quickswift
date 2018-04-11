//
//  InfoPlist.swift
//  QuickSwift
//
//  Created by tcui on 8/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

/// Some common plist keys
///
public enum InfoPlist: String {

    case version = "CFBundleShortVersionString"
    case build = "CFBundleVersion"
    case bundleId = "CFBundleIdentifier"
    case bundleName = "CFBundleName"
    case minOSVersion = "MinimumOSVersion"

    public static var all: [InfoPlist] {
        return [.version, .build, .bundleId, .bundleName, .minOSVersion]
    }

    public var value: String {
        guard let value = dictionary()[rawValue] as? String else {
            return ""
        }

        return value
    }

    public func dictionary() -> [String: Any] {
        return Bundle.main.infoDictionary ?? [:]
    }
}
