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
    func toTemplateImage() -> UIImage { return withRenderingMode(.alwaysTemplate)}
}

public extension Data {
    func toImage() -> UIImage? { return UIImage(data: self) }
}

public extension UIImage {
    private struct AssociatedKey {
        static var preferredSize = "preferredSize"
        static var preferredColor = "preferredColor"
    }

    public var preferredSize: CGSize {
        get {
            return getAssociatedObject(self, key: &AssociatedKey.preferredSize, default: CGSize(width: width, height: height))
        }
        set {
            setAssociatedObject(self, key: &AssociatedKey.preferredSize, newValue: newValue)
        }
    }

    public var preferredColor: UIColor? {
        get {
            return getAssociatedOptionalObject(self, key: &AssociatedKey.preferredColor)
        }
        set {
            setAssociatedOptionalObject(self, key: &AssociatedKey.preferredColor, newValue: newValue)
        }
    }
}
