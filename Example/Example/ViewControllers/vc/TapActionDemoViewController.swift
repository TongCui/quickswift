//
//  TapActionDemoViewController.swift
//  Example
//
//  Created by tcui on 17/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit

final class TapActionDemoViewController: UITableViewController {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActions(1)
    }
    
    func addActions(_ count: Int) {
        button.addHandler(for: .touchUpInside) { (button: UIButton) in
            print("\(button.title(for: .normal)!) did press \(count)")
        }
        
        label.addTapHandler { (label : UILabel) in
            print("\(label.text!) did press \(count)")
        }
        
        imageView.addTapHandler { (imageView: UIImageView) in
            print("imageView did press \(count)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addActions(2)
    }
}
