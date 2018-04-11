//
//  BarButtonAnimator.swift
//  TopwinRestaurants
//
//  Created by tcui on 18/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

private protocol BarButtonAnimatorConst {
    var imageSizeLarge: CGFloat { get set }
    var imageSizeSmall: CGFloat { get set }
    var imageRightMargin: CGFloat { get set }
    var imageBottomMarginLarge: CGFloat { get set }
    var imageBottomMarginSmall: CGFloat { get set }
    var navBarHeightLarge: CGFloat { get set }
    var navBarHeightSmall: CGFloat { get set }
}

public class BarButtonAnimator {
    public let view: UIView

    private var portraitConst = PortraitConst()
    private var landscapeConst = LandscapeConst()
    public var size: CGSize

    private struct PortraitConst: BarButtonAnimatorConst {
        var imageSizeLarge: CGFloat = 40
        var imageSizeSmall: CGFloat = 32
        var imageRightMargin: CGFloat = 16
        var imageBottomMarginLarge: CGFloat = 12
        var imageBottomMarginSmall: CGFloat = 6
        var navBarHeightLarge: CGFloat = 96.5
        var navBarHeightSmall: CGFloat = 44
    }

    private struct LandscapeConst: BarButtonAnimatorConst {
        var imageSizeLarge: CGFloat = 26
        var imageSizeSmall: CGFloat = 26
        var imageRightMargin: CGFloat = 16
        var imageBottomMarginLarge: CGFloat = 3
        var imageBottomMarginSmall: CGFloat = 3
        var navBarHeightLarge: CGFloat = 32
        var navBarHeightSmall: CGFloat = 32
    }

    var imageRight: NSLayoutConstraint!
    var imageBottom: NSLayoutConstraint!
    var imageHeight: NSLayoutConstraint!
    var imageWidth: NSLayoutConstraint!

    public init(target view: UIView, viewController: UIViewController) {
        self.view = view
        self.size = viewController.view.frame.size
        view.alpha = 0
        if let navigationBar = viewController.navigationController?.navigationBar {
            navigationBar.addSubview(view)
            updateAutoLayout(on:navigationBar)

            navigationBar.setNeedsLayout()
            navigationBar.layoutIfNeeded()
        }
    }

    public func updateAutoLayout(on navigationBar: UINavigationBar) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let rightAnchor: NSLayoutXAxisAnchor
        if #available(iOS 11.0, *) {
            rightAnchor = navigationBar.safeAreaLayoutGuide.rightAnchor
        } else {
            rightAnchor = navigationBar.rightAnchor
        }
        imageRight = view.rightAnchor.constraint(equalTo: rightAnchor, constant: -portraitConst.imageRightMargin)
        imageBottom = view.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -portraitConst.imageBottomMarginLarge)
        imageHeight = view.heightAnchor.constraint(equalToConstant: portraitConst.imageSizeLarge)
        imageWidth = view.widthAnchor.constraint(equalTo: view.heightAnchor)

        NSLayoutConstraint.activate([
            imageRight,
            imageBottom,
            imageHeight,
            imageWidth
            ])
    }

    private func currentConst() -> BarButtonAnimatorConst {
        return self.size.isPortrait ? portraitConst : landscapeConst
    }

    public func updateOritention(size: CGSize) {
        self.size = size
        let const = currentConst()
        imageRight.constant = -const.imageRightMargin
        imageBottom.constant = -const.imageBottomMarginLarge
        imageHeight.constant = const.imageSizeLarge
        moveAndResizeImage(for: const.navBarHeightSmall)
    }

    public func showImage(_ show: Bool, _ animated: Bool) {
        UIView.animate(withDuration:animated ? 0.12 : 0) {
            self.view.alpha = show ? 1.0 : 0.0
        }
    }

    public func moveAndResizeImage(for height: CGFloat) {
        let const = currentConst()
        let coeff: CGFloat = {
            let delta = height - const.navBarHeightSmall
            let heightDifferenceBetweenStates = (const.navBarHeightLarge - const.navBarHeightSmall)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = const.imageSizeSmall / const.imageSizeLarge

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = const.imageSizeLarge * (1.0 - factor) // 8.0

        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = const.imageBottomMarginLarge - const.imageBottomMarginSmall + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (const.imageBottomMarginSmall + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        // print("height \(height) - yTranslation \(yTranslation) - scale \(scale)===")
        // print([imageRight?.constant, imageBottom?.constant, imageHeight?.constant])
        view.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
}

public protocol BarButtonAnimating {
    var barAnimator: BarButtonAnimator { get }
}

extension BarButtonAnimating where Self: LifeCycleManagedViewController {
    public func setupBarAnimator() {
        self.lifeCycleManager
            .addAction(.viewWillAppear) { [weak self] animated in
                if let animated = animated as? Bool {
                    self?.barAnimator.showImage(true, animated)
                }
            }
            .addAction(.viewWillDisappear) { [weak self] animated in
                if let animated = animated as? Bool {
                    self?.barAnimator.showImage(false, animated)
                }
            }
            .addAction(.viewWillTransition) { [weak self] size in
                if let size = size as? CGSize {
                    self?.barAnimator.updateOritention(size: size)
                }
            }
            .addAction(.scrollViewDidScroll) { [weak self] _ in
                if let height = self?.navigationController?.navigationBar.frame.height {
                    self?.barAnimator.moveAndResizeImage(for: height)
                }
            }

    }
}
