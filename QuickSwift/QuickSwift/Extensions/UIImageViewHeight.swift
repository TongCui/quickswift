//
//  UIImageViewHeight.swift
//  QuickSwift
//
//  Created by tcui on 25/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension UIImageView {
    public enum ImageHeight: CustomStringConvertible {
        case height(CGFloat)
        case imageRatio

        public var description: String {
            switch self {
            case .height(let height):   return "height_\(height)"
            case .imageRatio:           return "image_ratio"
            }
        }
    }

    func updateAutolayout(imageHeight: ImageHeight) {

        switch imageHeight {
        case .height(let height):
            snp.makeConstraints { (make) in
                make.height.equalTo(height)
            }
        case .imageRatio:
            guard let image = self.image else {
                return
            }
            snp.makeConstraints { (make) in
                make.width.equalTo(snp.height).multipliedBy(image.width / image.height)
            }
        }
    }
}
