//
//  OptionCellItem.swift
//  QuickSwift
//
//  Created by tcui on 25/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

open class OptionCellItem<Key: Equatable>: CellItemProtocol {

    public enum SelectionIconType: CustomStringConvertible {
        case `default`
        //  tintColor
        case checkmark(UIColor)
        //  icon
        case image(UIImage)
        //  normal icon, selected icon
        case images(UIImage, UIImage)

        public var description: String {
            switch self {
            case .default:
                return "default"
            case .checkmark(let color):
                return "checkmark_\(color.hexString)"
            case .image(let image):
                return "image_\(image.preferredSize)"
            case .images(let image, _):
                return "images_\(image.preferredSize)"
            }
        }
    }

    public var registerType: TableViewRegisterType = .class(OptionTextCell.self)
    public var identifier: String
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public private(set) var key: Key
    public private(set) var text: String
    public private(set) var image: UIImage?
    public private(set) var isMultiSelectable: Bool
    public private(set) var selectionIconType: SelectionIconType

    public var textIconSpace: CGFloat = .defaultMargin
    public var isSelected: Bool
    public weak var sectionItem: SectionItemProtocol?

    public init(key: Key, text: String, sectionItem: SectionItemProtocol, image: UIImage? = nil, isMultiSelectable: Bool = false, selectionIconType: SelectionIconType = .default, optionDidSelected: @escaping (Key) -> Void) {
        self.sectionItem = sectionItem
        self.identifier = "option_cell_image\(image.isNil.toI())_\(selectionIconType) "
        self.key = key
        self.text = text
        self.image = image
        self.isMultiSelectable = isMultiSelectable
        self.isSelected = false
        self.selectionIconType = selectionIconType
        cellConfigurator.cellHeight = .automaticDimension
        add(action: .cellDidSelect) { [unowned self] (params) in
            if let sectionItem = self.sectionItem, let cell = params.cell {
                self.updateSelections(section: sectionItem)
                if cell.selectionStyle == .none {
                    params.tableView?.reloadData()
                } else {    //  Delay 0.1s for deselecting cell animation
                    params.tableView?.reloadData(after: 0.1)
                }
            }
            optionDidSelected(self.key)
        }
    }

    private func updateSelections(section: SectionItemProtocol) {
        if isMultiSelectable {
            isSelected = isSelected.toggled
        } else {
            section.cellItems.forEach { (cellItem) in
                if let cellItem = cellItem as? OptionCellItem {
                    cellItem.isSelected = false
                }
            }
            isSelected = true
        }
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? OptionTextCell {
            cell.optionLabel.text = text
            if let image = self.image {
                cell.iconImageView.isHidden = false
                cell.iconImageView.image = image
                cell.iconImageView.updateToPreferred(image)
                cell.optionLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(cell.iconImageView.snp.right).offset(textIconSpace)
                }
            } else {
                cell.iconImageView.isHidden = true
                cell.optionLabel.snp.makeConstraints { (make) in
                    make.leading.equalToSuperview().offset(cellConfigurator.cellContentEdges.left)
                }
            }

            setSelectionIcon(cell: cell)
        }
    }

    func setSelectionIcon(cell: OptionTextCell) {
        switch selectionIconType {
        case .default:
            cell.accessoryType = isSelected ? .checkmark : .none
        case .checkmark(let tintColor):
            cell.tintColor = tintColor
            cell.accessoryType = isSelected ? .checkmark : .none
        case .image(let image):
            cell.accessoryType = .none
            cell.selectionImageView.image = isSelected ? image : nil
            cell.selectionImageView.updateToPreferred(image)
        case .images(let normalImage, let selectedImage):
            let image = isSelected ? selectedImage : normalImage
            cell.selectionImageView.image = image
            cell.selectionImageView.updateToPreferred(image)
        }
    }

}

open class OptionTextCell: CommonInitTableCell {

    public lazy var iconImageView = UIImageView()
    public lazy var optionLabel = UILabel()
    public lazy var selectionImageView = UIImageView()

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(iconImageView)
        contentView.addSubview(optionLabel)
        contentView.addSubview(selectionImageView)
        iconImageView.contentMode = .scaleAspectFit
        selectionImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        selectionImageView.clipsToBounds = true

        let margin: CGFloat = .defaultMargin

        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(margin)
        }

        optionLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
        }

        selectionImageView.snp.makeConstraints { (make) in
            make.left.equalTo(optionLabel.snp.right).offset(margin).priority(.medium)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-margin)
        }
    }
}
