//
//  VerticalSwipeSegue.swift
//  Example
//
//  Created by tcui on 1/6/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class VerticalSwipeSegue: UIStoryboardSegue {
    override func perform() {
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        let originalFrame = fromVC.view.frame
        fromVC.view.superview?.addSubview(toVC.view)
        
        toVC.view.frame = originalFrame.offsetBy(dx: 0, dy: originalFrame.size.height)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = originalFrame.offsetBy(dx: 0, dy: -originalFrame.size.height / 8)
            toVC.view.frame = originalFrame
        }) { (finished) in
            fromVC.navigationController?.pushViewController(toVC, animated: false)
        }
    }
}

class VerticalSwipeUnwindSegue: UIStoryboardSegue {
    override func perform() {
        let duration: TimeInterval = 0.4
        let fromVC = source
        let toVC = destination
        
        let originalFrame = fromVC.view.frame
        fromVC.view.superview?.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        toVC.view.frame = originalFrame.offsetBy(dx: 0, dy: -originalFrame.size.height / 8)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = originalFrame.offsetBy(dx: 0, dy: originalFrame.size.height)
            toVC.view.frame = originalFrame
        }) { (finished) in
            fromVC.navigationController?.popViewController(animated: false)
        }
    }
}
