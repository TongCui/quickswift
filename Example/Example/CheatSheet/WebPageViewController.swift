//
//  WebPageViewController.swift
//  Example
//
//  Created by tcui on 2/5/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import WebKit

final class WebPageViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var pageUrl: String?
    var pageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        navigationItem.title = pageTitle
        spinner.startAnimating()
        if let pageUrl = pageUrl, let url = URL(string: pageUrl) {
            webView.load(URLRequest(url: url))
        }
    }
}

extension WebPageViewController: WKNavigationDelegate {
    
    func hideSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hideSpinner()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        hideSpinner()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideSpinner()
    }
}
