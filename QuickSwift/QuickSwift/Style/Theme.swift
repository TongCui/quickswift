//
//  Theme.swift
//  QuickSwift
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

//
//  This is just an example.
//

enum LabelStyles: StyleFactory {
    case leftLabel
    case centerLabel
    case rightLabel

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
        }

    }

}

extension Style where Element == UILabel {
    @discardableResult
    func with(_ styles: LabelStyles...) -> Style {
        styles.forEach { $0.styleItem.apply(on: element) }
        return self
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



