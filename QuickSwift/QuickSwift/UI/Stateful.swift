//
//  Stateful.swift
//  QuickSwift
//
//  Created by tcui on 26/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

public protocol Statefuled: AnyObject {
    var container: UIView { get }
    var stateEdgeInsets: UIEdgeInsets { get set }
    var stateViews: [StatefulState: [UIView]] { get set }
    var stateTransitions: [StatefulState: (UIView?) -> Void ] { get set }
}

public extension Statefuled where Self: UITableViewCell {
    var container: UIView { return contentView }
}

public extension Statefuled where Self: UIView {

    var container: UIView { return self }

    public func setState(_ state: StatefulState) {
        stateChange(from: state, to: state, animated: false)
    }

    public func stateChange(from: StatefulState, to: StatefulState, animated: Bool) {
        print("State change from \(from) to \(to)")

        guard let fromViews = stateViews[from], let toViews = stateViews[to] else {
            hideStateViewsExcept(to)
            print("Warning: missing state view")
            return
        }

        guard from != to else {
            stateTransitions[to]?(targetStateView(for: to))
            hideStateViewsExcept(to)
            return
        }

        hideStateViewsExcept(from)

        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            fromViews.forEach { $0.alpha = 0}
            toViews.forEach { $0.alpha = 1}

        }) { [weak self] _ in
            self?.stateTransitions[to]?(self?.targetStateView(for: to))
        }

    }

    fileprivate func targetStateView(for state: StatefulState) -> UIView? {
        guard state != .success else {
            return nil
        }

        return stateViews[state]?.first
    }

    public func setStateSuccessViews(_ views: [UIView]) {
        stateViews[.success] = views
    }

    public func setStateView(for state: StatefulState, view: UIView ) {
        guard state != .success else {
            return
        }
        view.alpha = 0

        if view.superview == nil {
            container.addSubview(view)
        }

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: stateEdgeInsets.left),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -stateEdgeInsets.right),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: stateEdgeInsets.top),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -stateEdgeInsets.bottom)
            ])

        stateViews[state] = [view]
    }

    public func setStateTransition(for state: StatefulState, transition: @escaping (UIView?) -> Void) {
        stateTransitions[state] = transition
    }

    fileprivate func hideStateViewsExcept(_ state: StatefulState) {
        stateViews.forEach { (curState, views) in
            views.forEach { $0.alpha = (state == curState ? 1 : 0) }
        }
    }

}

public enum StatefulState: Int {
    case loading
    case success
    case fail
    case empty

    public static var all: [StatefulState] {
        return [.loading, .success, .fail, .empty]
    }
}

extension StatefulState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .loading:  return "loading"
        case .success:  return "success"
        case .fail:     return "fail"
        case .empty:    return "empty"
        }
    }
}
