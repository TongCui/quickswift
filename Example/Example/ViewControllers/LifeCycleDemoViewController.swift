//
//  LifeCycleDemoViewController.swift
//  Example
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class TestDeinitViewController: LifeCycleManagedViewController {
    deinit {
        print("ViewController - deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test Deinit"
        view.backgroundColor = .white
    }
}

final class LifeCycleDemoViewController: LogListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        append(line: "ViewController - viewDidLoad")
    }
    
    @IBAction func testDenitButtonDidPress(_ sender: UIBarButtonItem) {
        let vc = TestDeinitViewController()
        vc.lifeCycleManager.addAction(.deinit) { _ in
            print("LifeCycleManager - deinit")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        append(line: "ViewController - viewWillAppear - \(animated)")
    }
    
}
