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
    public enum LifeCycle: Hashable {
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

        private func toS() -> String {
            switch self {
            case .viewDidLoad:
                return "viewDidLoad"
            case .viewWillAppear:
                return "viewWillAppear"
            case .viewDidAppear:
                return "viewDidAppear"
            case .viewWillDisappear:
                return "viewWillDisappear"
            case .viewDidDisappear:
                return "viewDidDisappear"
            case .deinit:
                return "deinit"
            }
        }
    }
}

public class LifeCycleManager {
    public typealias LifeCycleType = UIViewController.LifeCycle

    var actions: [LifeCycleType: [(Bool) -> Void]] = [:]

    @discardableResult
    public func addAction(_ type: LifeCycleType, action: @escaping (Bool) -> Void) -> Self {
        if var values = actions[type] {
            values.append(action)
        } else {
            actions[type] = [action]
        }

        return self
    }

    public func cleanAction(_ type: LifeCycleType) {
        actions.removeValue(forKey: type)
    }

    public func performAction(_ type: LifeCycleType, animated: Bool) {
        guard let values = actions[type] else {
            return
        }

        values.forEach { (action) in
            action(animated)
        }
    }
}

open class LifeCycleManagedViewController: UIViewController, LifeCycleManaged {

    public var lifeCycleManager = LifeCycleManager()

    deinit {
        lifeCycleManager.performAction(.deinit, animated: false)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        lifeCycleManager.performAction(.viewDidLoad, animated: false)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycleManager.performAction(.viewWillAppear, animated: animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifeCycleManager.performAction(.viewDidAppear, animated: animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifeCycleManager.performAction(.viewWillDisappear, animated: animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifeCycleManager.performAction(.viewDidDisappear, animated: animated)
    }
}

//extension UIScrollViewDelegate where Self : LifeCycleManaged {
//    
//}
