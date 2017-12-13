//
//  ViewController.swift
//  Example
//
//  Created by tcui on 27/11/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let array = [12, 13, 14]
        print("array \(array) sum is \(array.sum())")

        let model = AnnieModel(age: 12, name: "tcui")
        print("\(model.greeting())")
        model.ping {
            print("Hello World!")
        }
        
//        let data = try? JSONEncoder().encode(model)
        
        let error = TypeConvertError.cannotConvert(String.self, Int.self)
        
        print("\(error.toS)")
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
