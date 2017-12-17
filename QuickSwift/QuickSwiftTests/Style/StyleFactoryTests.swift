//
//  StyleFactoryTests.swift
//  QuickSwiftTests
//
//  Created by tcui on 17/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation
@testable import QuickSwift

//
//  This is just an example.
//

enum LabelStyles: StyleFactory {
    case leftLabel
    case centerLabel
    case rightLabel
    case redLabel
    case greenLabel

    var styleItem: StyleItem<UILabel> {
        switch self {
        case .leftLabel:
            return StyleItem { label in
                label.textAlignment = .left
            }
        case .centerLabel:
            return StyleItem { label in
                label.textAlignment = .center
            }
        case .rightLabel:
            return StyleItem { label in
                label.textAlignment = .right
            }
        case .redLabel:
            return StyleItem { label in
                label.textColor = UIColor.red
            }

        case .greenLabel:
            return StyleItem { label in
                label.textColor = UIColor.green
            }
        }
    }
}

enum ButtonStyles: StyleFactory {
    case redButton
    case greenButton

    var styleItem: StyleItem<UIButton> {
        switch self {
        case .redButton:
            return StyleItem { button in
                button.setTitleColor(UIColor.red, for: .normal)
            }
        case .greenButton:
            return StyleItem { button in
                button.setTitleColor(UIColor.green, for: .normal)
            }
        }
    }
}

enum ImageViewStyles: StyleFactory {
    case redTintImageView
    case greenTintImageView

    var styleItem: StyleItem<UIImageView> {
        switch self {
        case .redTintImageView:
            return StyleItem { button in
                button.tintColor = UIColor.red
            }
        case .greenTintImageView:
            return StyleItem { button in
                button.tintColor = UIColor.green
            }
        }
    }
}
