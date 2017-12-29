//
//  LoadingCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class LoadingCellItem: CellItemProtocol {

    public var isLoading: Bool = false
    public var identifier: String = "loading_cell"
    public var settings: CellSettings = CellSettings()

    public init() {
        settings.cellHeight = kDefaultCellHeight
    }

    public func register(tableView: UITableView) {
        tableView.register(LoadingCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? LoadingCell {
            cell.selectionStyle = .none
            cell.spinner.startAnimating()
            self.isLoading = true
        }

        return tableCell
    }

    public func cell(tableView: UITableView, didSelectRowAt index: IndexPath) {

    }

}

public class LoadingCell: BuiltInCell {

    public lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(spinner)

        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
