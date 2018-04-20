//
//  ViewControllerLifecycleHandler.swift
//  QuickSwift
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public protocol LifeCycleManaged {
    var lifeCycleManager: LifeCycleManager { get }
}

public extension UIViewController {
    public enum LifeCycle: String, Hashable {
        public var hashValue: Int {return self.toS().hashValue }

        public static func ==(lhs: UIViewController.LifeCycle, rhs: UIViewController.LifeCycle) -> Bool {
            return lhs.toS() == rhs.toS()
        }

        case viewDidLoad
        case viewWillAppear
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        case `deinit`
        case scrollViewDidScroll
        case scrollViewWillBeginDragging
        case scrollViewWillEndDragging
        case scrollViewDidEndDragging
        case viewWillTransition

        private func toS() -> String {
            return rawValue
        }
    }
}

public class LifeCycleManager {
    public typealias LifeCycleType = UIViewController.LifeCycle

    var actions: [LifeCycleType: [(Any?) -> Void]] = [:]

    @discardableResult
    public func addAction(_ type: LifeCycleType, action: @escaping (Any?) -> Void) -> Self {
        if actions.has(key: type) {
            actions[type]?.append(action)
        } else {
            actions[type] = [action]
        }

        return self
    }

    public func cleanAction(_ type: LifeCycleType) {
        actions.removeValue(forKey: type)
    }

    public func performAction(_ type: LifeCycleType, param: Any?) {
        guard let values = actions[type] else {
            return
        }

        values.forEach { (action) in
            action(param)
        }
    }

}

open class LifeCycleManagedViewController: UIViewController, LifeCycleManaged {

    public var lifeCycleManager = LifeCycleManager()

    deinit {
        lifeCycleManager.performAction(.deinit, param: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        lifeCycleManager.performAction(.viewDidLoad, param: nil)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycleManager.performAction(.viewWillAppear, param: animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifeCycleManager.performAction(.viewDidAppear, param: animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifeCycleManager.performAction(.viewWillDisappear, param: animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifeCycleManager.performAction(.viewDidDisappear, param: animated)
    }
}

extension LifeCycleManagedViewController {
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        lifeCycleManager.performAction(.viewWillTransition, param: size)
    }
}

extension LifeCycleManagedViewController: UIScrollViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lifeCycleManager.performAction(.scrollViewDidScroll, param: scrollView)
    }

    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lifeCycleManager.performAction(.scrollViewWillBeginDragging, param: scrollView)
    }

    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        lifeCycleManager.performAction(.scrollViewWillEndDragging, param: [scrollView, velocity, targetContentOffset])
    }

    open  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lifeCycleManager.performAction(.scrollViewDidEndDragging, param: [scrollView, decelerate])
    }
}
