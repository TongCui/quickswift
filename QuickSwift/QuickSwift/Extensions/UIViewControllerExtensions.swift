//
//  UIViewControllerExtensions.swift
//  QuickSwift
//
//  Created by tcui on 26/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import Foundation

public extension UIViewController {
    public func setLargetTitles(_ enabled: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = enabled
        }
    }
}

public struct SegueContext {
    var segueIdentifier: String
    var prepareSegue: (UIStoryboardSegue) -> Void
}

extension UIViewController {
    public func performSegue<T>(for segueIdentifier: String, context action : @escaping (T) -> Void) {
        let segueContext = SegueContext(segueIdentifier: segueIdentifier) { (segue) in
            if let viewController = segue.destination as? T, segue.identifier == segueIdentifier {
                action(viewController)
            }
        }

        performSegue(withIdentifier: segueIdentifier, sender: segueContext)
    }

    public func prepareWithSegueContext(for segue: UIStoryboardSegue, sender: Any?) {
        if let context = sender as? SegueContext {
            context.prepareSegue(segue)
        }
    }
}
