//
//  NavigationBarSearchViewController.swift
//  Example
//
//  Created by tcui on 13/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import QuickSwift

final class NavigationBarSearchViewController: LogListViewController {
    
    var allCellItems: [OneLineTextCellItem] = []
    let lines: [String] = {
        return (1..<30).map{ "\($0)). Line \($0)" }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        append(lines: lines)
        setupSearchBar()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Placeholder"
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
}

extension NavigationBarSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let lines:[String]
        if let keyword = searchController.searchBar.text, !keyword.isEmpty {
            lines = self.lines.filter { $0.contains(keyword)}
        } else {
            lines = self.lines
        }
        
        adapter.sections.first?.clear()
        append(lines: lines)
        adapter.reloadData()
    }
}



