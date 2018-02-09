//
//  IPAddressDemoViewController.swift
//  Example
//
//  Created by tcui on 6/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class IPAddressDemoViewController: LogListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        append(line: "IP Address : (\(Networking.getIPAddress() ?? "Not Available"))")
    }

}
