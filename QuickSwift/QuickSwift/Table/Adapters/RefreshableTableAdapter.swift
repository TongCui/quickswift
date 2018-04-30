//
//  RefreshableTableAdapter.swift
//  QuickSwift
//
//  Created by tcui on 11/4/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public protocol RefreshableTableAdapterContainer: UIScrollViewDelegate {
    var tableView: UITableView { get }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
}

extension RefreshableTableAdapterContainer where Self: UIViewController {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }
}

open class RefreshableTableAdapter: HeaderFooterTableAdapter {

    open var refreshAction: (() -> Void)?
    open lazy var refreshControl = UIRefreshControl()
    open var container: RefreshableTableAdapterContainer? {
        didSet {
            container?.tableView.refreshControl = refreshControl
            delegateProvider.scrollDelegate = container
        }
    }

    public func scrollViewDidEndDraggingMonitor(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.refreshControl.isRefreshing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refreshAction?()
            }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDidEndDraggingMonitor(scrollView, willDecelerate: decelerate)
    }

}
