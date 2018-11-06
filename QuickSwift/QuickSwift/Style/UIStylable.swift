//
//  Stylable.swift
//  QuickSwift
//
//  Created by tcui on 16/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit

public protocol UIStylable {
    associatedtype Element
    var uiStyle: UIStyle<Element> { get }
    func copyStyle(_ another: Element)
}

extension UIStylable where Self: UIView {
    func copyCommonView(_ another: UIView) {
        backgroundColor = another.backgroundColor
        alpha = another.alpha
        tintColor = another.tintColor
    }
}

// MARK: - UILabel
extension UILabel: UIStylable {
    public var uiStyle: UIStyle<UILabel> { return UIStyle(element: self) }

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
extension UIButton: UIStylable {
    public var uiStyle: UIStyle<UIButton> { return UIStyle(element: self) }

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

    func states() -> [UIControl.State] {
        return [.normal, .highlighted, .disabled, .selected]
    }
}

// MARK: - UIImageView
extension UIImageView: UIStylable {
    public var uiStyle: UIStyle<UIImageView> { return UIStyle(element: self) }

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

// MARK: - UITableViewCell
extension UITableViewCell: UIStylable {
    public var uiStyle: UIStyle<UITableViewCell> { return UIStyle(element: self) }

    public func copyStyle(_ another: UITableViewCell) {
        copyCommonView(another)

        selectionStyle = another.selectionStyle
        accessoryType = another.accessoryType
        contentView.backgroundColor = another.backgroundColor
        contentView.tintColor = another.tintColor
    }
}

// MARK: - UITableView
extension UITableView: UIStylable {
    public var uiStyle: UIStyle<UITableView> { return UIStyle(element: self) }

    public func copyStyle(_ another: UITableView) {
        copyCommonView(another)

    }
}

// MARK: - UISlider
extension UISlider: UIStylable {
    public var uiStyle: UIStyle<UISlider> { return UIStyle(element: self) }

    public func copyStyle(_ another: UISlider) {
        copyCommonView(another)
    }
}

// MARK: - UISwitch
extension UISwitch: UIStylable {
    public var uiStyle: UIStyle<UISwitch> { return UIStyle(element: self) }

    public func copyStyle(_ another: UISwitch) {
        copyCommonView(another)
    }
}
