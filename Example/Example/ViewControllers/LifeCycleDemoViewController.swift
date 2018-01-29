//
//  LifeCycleDemoViewController.swift
//  Example
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class LifeCycleDemoViewController: LifeCycleManagedViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    var infos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendInfo("ViewController - viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appendInfo("ViewController - viewWillAppear - \(animated)")
    }
    
    func appendInfo(_ info: String) {
        infos.append(info)
        infoLabel.text = infos.joined(separator: "\n")
    }
}
