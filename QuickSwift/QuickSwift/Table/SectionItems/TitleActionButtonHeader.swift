//
//  TitleActionButtonHeader.swift
//  QuickSwift
//
//  Created by tcui on 12/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import SnapKit

public class TitleActionButtonHeader: SectionHeaderFooterProtocol {

    public var identifier: String = "title_action_button_header"

    public var title: String?
    public var actionTitle: String
    public var height: CGFloat?
    public var left: CGFloat
    public var bottom: CGFloat

    public var action: ()->Void

    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(titleLabel)
        view.addSubview(actionButton)

        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()

    var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()

    public func register(tableView: UITableView) {
        tableView.register(TitleActionButtonHeader.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    public func view(tableView: UITableView, section: Int) -> UIView? {

        let view = container

        titleLabel.text = title!.repeat(10)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(left)
            make.bottom.equalToSuperview().offset(-bottom)
        }

        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.addHandler(for: .touchUpInside) {[weak self] (button) in
            self?.action()
        }

        actionButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-left)
            make.bottom.equalToSuperview().offset(-bottom)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
        }
        actionButton.contentEdgeInsets = UIEdgeInsets(top: .tableZero, left: .tableZero, bottom: .tableZero, right: .tableZero)
        actionButton.setTitleColor(.red, for: .normal)

        actionButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return view
    }

    init(title: String?, actionTitle: String, height: CGFloat?, action: @escaping () -> Void) {
        self.title = title
        self.actionTitle = actionTitle
        self.height = height
        self.left = .defaultMargin
        self.bottom = 5
        self.action = action
    }
}
