//
//  UIViewControllerExtensions.swift
//  QuickSwift
//
//  Created by tcui on 26/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension UIViewController {
    public func setLargetTitles(_ enabled: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = enabled
        }
    }
}
