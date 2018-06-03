//
//  ScaleSegue.swift
//  Example
//
//  Created by tcui on 1/6/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {
    override func perform() {
        let scale: CGFloat = 0.05
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        toVC.view.center = fromVC.view.center
        toVC.view.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        fromVC.view.superview?.addSubview(toVC.view)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toVC.view.transform = CGAffineTransform.identity
        }) { (finished) in
            fromVC.navigationController?.pushViewController(toVC, animated: false)
        }
    }
}

class ScaleUnwindSegue: UIStoryboardSegue {
    override func perform() {
        let scale: CGFloat = 0.05
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        fromVC.view.superview?.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            fromVC.view.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { (finished) in
            fromVC.navigationController?.popViewController(animated: false)
        }
    }
}
