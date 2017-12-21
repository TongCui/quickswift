//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

// Use Swizzling
public extension UIColor {
    
    @objc
    func yes(ok:Int) -> String {
        return "yes \(ok)"
    }
    
    @objc
    func no(ok:Int) -> String {
        return "no \(ok)"
    }
    
    
    @objc func colorDescription() -> String {
      return "color"
    }
    
}

class Book: NSObject {
    
}

extension Book {
    @objc
    func yes(ok:Int) -> String {
        return "yes \(ok)"
    }
    
    
    @objc
    func no(ok:Int) -> String {
        return "no \(ok)"
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(Book().yes(ok: 20))")
        print("\(Book().no(ok: 20))")
        
        Swizzle.swizzleInstanceMethods(forClass: Book.self, #selector(Book.yes(ok:)), #selector(Book.no(ok:)))
        print("\(Book().yes(ok: 20))")
        print("\(Book().no(ok: 20))")
//        print("\(Book().yes(ok: 12))")
//        print("\(Book().no(ok: 20))")
        
        // Do any additional setup after loading the view, typically from a nib.
        let array = [12, 13, 14]
        print("array \(array) sum is \(array.sum())")        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
