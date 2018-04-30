//
//  LoadingCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class LoadingCellItem: CellItemProtocol {

    public var registerType: TableViewRegisterType = .class(LoadingCell.self)
    public var identifier: String = "loading_cell"
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public var timeout: TimeInterval = 3
    public var isLoading: Bool = false
    public var loadingAction: () -> Void

    public init(loadingAction:@escaping () -> Void ) {
        self.loadingAction = loadingAction
        cellConfigurator.cellHeight = .defaultCellHeight
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? LoadingCell {
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
    }
}

open class LoadingCell: CommonInitTableCell {

    public lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(spinner)

        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
