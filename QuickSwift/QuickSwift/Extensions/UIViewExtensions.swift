//
//  UIViewExtensions.swift
//  QuickSwift
//
//  Created by tcui on 18/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

extension UIView {
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            if newValue != self.frame.origin.y {
                self.frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            if newValue != self.frame.maxY {
                self.frame = CGRect(x: self.frame.origin.x, y: newValue - self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            if newValue != self.frame.origin.x {
                self.frame = CGRect(x: newValue, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

    var right: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            if newValue != self.frame.maxX {
                self.frame = CGRect(x: newValue - self.frame.size.width, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            if newValue != self.frame.size.width {
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)
            }
        }
    }

    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            if newValue != self.frame.size.height {
                self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)
            }
        }
    }

    var midX: CGFloat {
        get {
            return self.frame.midX
        }
        set {
            if newValue != self.frame.midX {
                self.frame = CGRect(x: newValue - self.frame.size.width / (2 as CGFloat), y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

    var midY: CGFloat {
        get {
            return self.frame.midY
        }
        set {
            if newValue != self.frame.midY {
                self.frame = CGRect(x: self.frame.origin.x, y: newValue - self.frame.size.height / (2 as CGFloat), width: self.frame.size.width, height: self.frame.size.height)
            }
        }
    }

}

extension UIView {
    var isVisible: Bool {
        return self.window != nil
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        return findFirstResponderInView(topView: self)
    }

    func findFirstResponderInView(topView: UIView) -> UIView? {

        if topView.isFirstResponder {
            return topView
        }

        for subView in topView.subviews {
            if subView.isFirstResponder {
                return subView
            }

            if let targetFirstResponder = findFirstResponderInView(topView: subView) {
                return targetFirstResponder
            }
        }

        return nil
    }
}