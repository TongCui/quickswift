//
//  LoadingCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class LoadingCellItem: CellItemProtocol {

    public var timeout: TimeInterval = 3
    public var isLoading: Bool = false
    public var identifier: String = "loading_cell"
    public var settings: CellSettings = CellSettings()
    public var loadingAction: () -> Void

    public init(loadingAction:@escaping () -> Void ) {
        self.loadingAction = loadingAction
        cellHeight = .defaultCellHeight
    }

    public func register(tableView: UITableView) {
        tableView.register(LoadingCell.self, forCellReuseIdentifier: identifier)
    }

    open func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? LoadingCell {
            cell.selectionStyle = .none
            cell.spinner.startAnimating()
            if !isLoading {
                Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] _ in
                    self?.isLoading = false
                }
                loadingAction()
                isLoading = true
            }
        }

        return tableCell
    }
}

open class LoadingCell: BuiltInCell {

    public lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(spinner)

        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
