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

    case mainLabel
    case subLabel

    var styleItem: StyleItem<UILabel> {
        switch self {
        case .mainLabel:
            return StyleItem { label in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
                print("!!!!!!!!main label!!!!!!!!!")
            }
        case .subLabel:
            return StyleItem { label in
                label.font = UIFont.systemFont(ofSize: 12)
                label.textAlignment = .center
                print("!!!!!!!!sub label!!!!!!!!!")
            }
        }

    }

}

extension CombinedStyleItem where Element == UILabel {
    @discardableResult
    func and(_ style: LabelStyles ) -> CombinedStyleItem {
        styles.append(style.styleItem)
        return self
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

    case largeButton

    var styleItem: StyleItem<UIButton> {
        switch self {
        case .largeButton:
            return StyleItem { button in
                button.backgroundColor = UIColor.red
                button.setTitleColor(UIColor.green, for: .normal)
            }
        }
    }
}
