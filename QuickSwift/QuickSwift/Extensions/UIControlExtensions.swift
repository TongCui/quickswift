//
//  UIControlExtensions.swift
//  QuickSwift
//
//  Created by tcui on 29/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import Foundation

final class Target<Sender>: NSObject {
    let action: (Sender) -> Void

    init(_ action: @escaping (Sender) -> Void) {
        self.action = action
    }

    @objc
    func send(_ receiver: Any?) {
        if let receiver = receiver as? Sender {
            action(receiver)
        }

        if let gesture = receiver as? UIGestureRecognizer, let view = gesture.view as? Sender {
            action(view)
        }
    }
}

private struct UIControlPropertyKeys {
    static var controlHandler = "controlHandler"
}

extension UIControl {
    public func addHandler<T: UIControl>(for controlEvents: UIControlEvents, handler: @escaping (T) -> Void) {
        if let oldTarget = objc_getAssociatedObject(self, &UIControlPropertyKeys.controlHandler) as? Target<T> {
            self.removeTarget(oldTarget, action: #selector(oldTarget.send(_:)), for: controlEvents)
        }

        let target = Target<T>(handler)
        objc_setAssociatedObject(self, &UIControlPropertyKeys.controlHandler, target, .OBJC_ASSOCIATION_RETAIN)
        self.addTarget(target, action: #selector(target.send(_:)), for: controlEvents)
    }
}
