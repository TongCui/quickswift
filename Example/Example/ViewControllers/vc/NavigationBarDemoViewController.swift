//
//  NavigationBarDemoViewController.swift
//  Example
//
//  Created by tcui on 28/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class NavigationBarDemo1ViewController: LogListViewController {
    
    lazy var iconButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "icon_building")!.toTemplateImage()
        image.preferredColor = UIColor.red
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var barAnimator = BarButtonAnimator(target: iconButton, viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegateProvider.scrollDelegate = self
        (1..<30).forEach { append(line: "\($0)). Line \($0)") }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        barAnimator.showImage(false, animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        barAnimator.showImage(true, animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        barAnimator.updateOritention(size: size)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        guard let height = navigationController?.navigationBar.frame.height else { return }
        barAnimator.moveAndResizeImage(for: height)
    }
}

final class NavigationBarDemo2ViewController: LogListViewController, BarButtonAnimating {
    lazy var iconButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "icon_building")!.toTemplateImage()
        image.preferredColor = UIColor.red
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var barAnimator = BarButtonAnimator(target: iconButton, viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegateProvider.scrollDelegate = self
        (1..<30).forEach { append(line: "\($0)). Line \($0)") }
        setupBarAnimator()
    }
}

