//
//  UIImageExtensions.swift
//  QuickSwift
//
//  Created by tcui on 15/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

public extension UIImage {
    public var width: CGFloat { return self.size.width }

    public var height: CGFloat { return self.size.height }
}

public extension UIImage {
    func toJPEG() -> Data? { return UIImageJPEGRepresentation(self, 1) }
    func toPNG() -> Data? { return UIImagePNGRepresentation(self)}
}

public extension Data {
    func toImage() -> UIImage? { return UIImage(data: self) }
}
