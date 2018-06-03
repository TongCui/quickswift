//
//  CustomSegue2ViewController.swift
//  Example
//
//  Created by tcui on 31/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class CustomSegue2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear \(animated)")
    }

    @IBAction func test(_ sender: UIButton) {
        print(sender)
        print(self)
    }
    
}
