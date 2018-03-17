//
//  SegueDemoViewController.swift
//  Example
//
//  Created by tcui on 17/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

final class SegueDemoViewController: UIViewController {
  
    @IBAction func goDetail1(_ sender: UIButton) {
        performSegue(for: SegueIds.goSegueDetail1VC.rawValue) { (viewController: SegueDetailViewController) in
            viewController.title = "Detail1"
            viewController.content = "Greeting from Button 1"
        }
    }
    
    @IBAction func goDetail2(_ sender: UIButton) {
        performSegue(for: SegueIds.goSegueDetail2VC.rawValue) { (viewController: SegueDetailViewController) in
            viewController.title = "Detail2"
            viewController.content = "Greeting from Button 2"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        prepareWithSegueContext(for: segue, sender: sender)
    }
}


final class SegueDetailViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var content: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentLabel.text = content
    }
}
