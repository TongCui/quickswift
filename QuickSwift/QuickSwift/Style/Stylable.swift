//
//  Stylable.swift
//  QuickSwift
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

public protocol Stylable {
    associatedtype Element
    var style: Style<Element> { get }
    func copyStyle(_ another: Element)
}

extension Stylable where Self : UIView {
    func copyCommonView(_ another: UIView) {
        backgroundColor = another.backgroundColor
        alpha = another.alpha
        tintColor = another.tintColor
    }
}

// MARK: - UILabel
extension UILabel: Stylable {
    public var style: Style<UILabel> { return Style(element: self) }

    public func copyStyle(_ another: UILabel) {
        copyCommonView(another)

        font = another.font
        textColor = another.textColor
        textAlignment = another.textAlignment
        lineBreakMode = another.lineBreakMode
        adjustsFontSizeToFitWidth = another.adjustsFontSizeToFitWidth
        baselineAdjustment = another.baselineAdjustment
        minimumScaleFactor = another.minimumScaleFactor
        numberOfLines = another.numberOfLines
        highlightedTextColor = another.highlightedTextColor
        shadowColor = another.shadowColor
        shadowOffset = another.shadowOffset
        preferredMaxLayoutWidth = another.preferredMaxLayoutWidth
    }
}

// MARK: - UIButton
extension UIButton: Stylable {
    public var style: Style<UIButton> { return Style(element: self) }

    public func copyStyle(_ another: UIButton) {
        copyCommonView(another)

        adjustsImageWhenHighlighted = another.adjustsImageWhenHighlighted
        adjustsImageWhenDisabled = another.adjustsImageWhenDisabled

        showsTouchWhenHighlighted = another.showsTouchWhenHighlighted
        tintColor = another.tintColor
        contentEdgeInsets = another.contentEdgeInsets
        titleEdgeInsets = another.titleEdgeInsets
        imageEdgeInsets = another.imageEdgeInsets

        self.titleLabel?.copyStyle(another.titleLabel!)

        states().forEach { (state) in
            setTitleColor(another.titleColor(for: state), for: state)
            setTitleShadowColor(another.titleShadowColor(for: state), for: state)
            setBackgroundImage(another.backgroundImage(for: state), for: state)
            setImage(another.image(for: state), for: state)
        }
    }

    func states() -> [UIControlState] {
        return [.normal, .highlighted, .disabled, .selected]
    }
}

// MARK: - UIImageView
extension UIImageView: Stylable {
    public var style: Style<UIImageView> { return Style(element: self) }

    public func copyStyle(_ another: UIImageView) {
        copyCommonView(another)

        image = another.image
        highlightedImage = another.highlightedImage
        animationImages = another.animationImages
        highlightedAnimationImages = another.highlightedAnimationImages
        animationDuration = another.animationDuration
        animationRepeatCount = another.animationRepeatCount
    }
}
