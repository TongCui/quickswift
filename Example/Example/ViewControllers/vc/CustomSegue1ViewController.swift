//
//  CustomSegue1ViewController.swift
//  Example
//
//  Created by tcui on 31/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

class CustomSegue1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func back(_ sender: UIButton) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
}
