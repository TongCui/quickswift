//
//  StatefulCell.swift
//  Example
//
//  Created by tcui on 26/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class StatefulCellItem: CellItemProtocol {
    var identifier: String = "stateful_cell"
    var settings: CellSettings = CellSettings()
    var state: StatefulState
    var idx: Int
    
    init(idx: Int) {
        self.idx = idx % 10
        self.state = .loading
        
        
        add(action: .cellDidSelect) { (params) in
            if let cell = params.cell as? StatefulCell, let idx = StatefulState.all.index(of: self.state) {
                let nextState = StatefulState.all[(idx + 1) % StatefulState.all.count]
                cell.stateChange(from: self.state, to:nextState , animated: true)
                self.state = nextState
            }
        }
    }
    
    func register(tableView: UITableView) {
        tableView.register(StatefulCell.typeName.toNib(), forCellReuseIdentifier: identifier)
    }
    
    func mockLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(1.2, 3.2)) { [weak self] in
            
            let result = Bool.random()
            let cell: StatefulCell? = self?.getDisplayingCell()
            let newState: StatefulState
            if result {
                newState = .success
            } else {
                newState = .fail
            }
            
            self?.state = newState
            
            cell?.stateChange(from: .loading, to: newState, animated: true)
        }
    }
    
    func updateCellLayout() {
        
        if let _ = self.getDisplayingCell() {
            self.tableView?.beginUpdates()
            self.tableView?.endUpdates()
        } else {
//            print("Ignore updating \( indexPath?.description ?? "None" )")
        }
        
        
    }
    
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cell = tableCell as? StatefulCell {
            
            cell.setStateTransition(for: .loading) { [weak self] view in
                cell.shopDescription.text = "State is Loading"
                if let targetView = view as? StateLoadingView {
                    targetView.spinner.startAnimating()
                }
                self?.updateCellLayout()
                self?.mockLoad()
            }
            
            cell.setStateTransition(for: .empty) { [weak self]view in
                cell.shopDescription.text = "State is Empty"
                
                if let targetView = view as? StateEmptyView {
                    targetView.contentLabel.text = "Empty Content \(indexPath)"
                }
                self?.updateCellLayout()
            }
            
            cell.setStateTransition(for: .fail) { [weak self]view in
                cell.shopDescription.text = "State is Fail"
                if let targetView = view as? StateFailView {
                    targetView.titleLabel.text = "Fail Title \(indexPath)"
                    targetView.detailLabel.text = "Fail Title \(indexPath)"
                }
                self?.updateCellLayout()
            }
            
            cell.setStateTransition(for: .success) { [weak self]view in
                cell.shopDescription.text = (1...(self!.idx + 1)).map{ "Shop description line \($0)" }.joined(separator: "\n")
                if let targetView = view as? StateFailView {
                    targetView.titleLabel.text = "Fail Title \(indexPath)"
                    targetView.detailLabel.text = "Fail Title \(indexPath)"
                }
                self?.updateCellLayout()
            }
            
            
            cell.setState(state)
            cell.topLeft.text = "Title\(idx)"
            cell.topRight.text = "Date\(idx)"
            
        }
        
        return tableCell
    }
    
}


final class StatefulCell: UITableViewCell, Statefuled {
    
    var stateEdgeInsets: UIEdgeInsets = .zero
    var stateViews: [StatefulState : [UIView]] = [:]
    var stateTransitions: [StatefulState : (UIView?) -> Void] = [:]
    
    @IBOutlet weak var topLeft: UILabel!
    @IBOutlet weak var topRight: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        stateEdgeInsets = UIEdgeInsetsMake(topLeft.bottom + 2, .defaultMargin, .defaultMargin, .defaultMargin)
        setStateSuccessViews([shopImageView, shopDescription])
        setStateView(for: .empty, view: StateEmptyView(frame: .zero))
        setStateView(for: .loading, view: StateLoadingView(frame: .zero))
        setStateView(for: .fail, view: StateFailView(frame: .zero))
    }
    
}






