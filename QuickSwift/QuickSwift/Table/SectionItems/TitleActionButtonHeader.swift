//
//  TitleActionButtonHeader.swift
//  QuickSwift
//
//  Created by tcui on 12/2/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import SnapKit

class TitleActionButtonHeaderView: CommonInitTableHeaderFooterView {
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

    open override func commonInit() {
        super.commonInit()

        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)

        actionButton.contentEdgeInsets = UIEdgeInsets(top: .tableZero, left: .tableZero, bottom: .tableZero, right: .tableZero)
        actionButton.setTitleColor(.blue, for: .normal)
    }
}

open class TitleActionButtonHeader: SectionHeaderFooterProtocol {

    public var registerType: TableViewRegisterType = .class(TitleActionButtonHeaderView.self)
    public var identifier: String = "title_action_button_header"
    public var title: String?
    public var height: CGFloat?

    public var actionTitle: String
    public var left: CGFloat
    public var bottom: CGFloat
    public var action: () -> Void

    private var headerTitle: String?

    init(title: String?, actionTitle: String, height: CGFloat?, action: @escaping () -> Void) {
        self.headerTitle = title
        self.actionTitle = actionTitle
        self.height = height
        self.left = .defaultMargin
        self.bottom = 5
        self.action = action
    }

    open func render(view: UITableViewHeaderFooterView) {
        if let view = view as? TitleActionButtonHeaderView {

            view.titleLabel.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(left)
                make.bottom.equalToSuperview().offset(-bottom)
            }

            view.actionButton.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-left)
                make.bottom.equalToSuperview().offset(-bottom)
                make.leading.equalTo(view.titleLabel.snp.trailing).offset(5)
            }

            view.actionButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            view.actionButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)

            view.titleLabel.text = headerTitle
            view.actionButton.setTitle(actionTitle, for: .normal)
            view.actionButton.addHandler(for: .touchUpInside) {[weak self] (button) in
                self?.action()
            }
        }
    }
}
