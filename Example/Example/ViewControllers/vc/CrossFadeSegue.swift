//
//  CrossFadeSegue.swift
//  Example
//
//  Created by tcui on 31/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class CrossFadeSegue: UIStoryboardSegue {
    
    override func perform() {
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        toVC.view.center = fromVC.view.center
        fromVC.view.superview?.addSubview(toVC.view)
        
        UIView.transition(from: fromVC.view, to: toVC.view, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve) { (finished) in
            fromVC.navigationController?.pushViewController(toVC, animated: false)
        }
    }
}

class CrossFadeUnwindSegue: UIStoryboardSegue {
    
    override func perform() {
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        toVC.view.center = fromVC.view.center
        fromVC.view.superview?.addSubview(toVC.view)
        
        UIView.transition(from: fromVC.view, to: toVC.view, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve) { (finished) in
            fromVC.navigationController?.popViewController(animated: false)
        }
    }
}
