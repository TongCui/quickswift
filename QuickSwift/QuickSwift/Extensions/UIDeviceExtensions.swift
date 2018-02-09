//
//  UIDeviceExtensions.swift
//  QuickSwift
//
//  Created by tcui on 30/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension UIDevice {
    public var isPortrait: Bool {
        return UIApplication.shared.statusBarOrientation.isPortrait
    }

    public var isLandscape: Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }

    public var isIPhone: Bool {
        return userInterfaceIdiom == .phone
    }

    public var isIPad: Bool {
        return userInterfaceIdiom == .pad
    }
}
