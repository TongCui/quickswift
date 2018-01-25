//
//  OptionCellItem.swift
//  QuickSwift
//
//  Created by tcui on 25/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

public class OptionCellItem: CellItemProtocol {

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

    public var text: String
    public var image: UIImage?
    public var isMultiSelectable: Bool
    public var isSelected: Bool
    public var selectionIconType: SelectionIconType
    public var identifier: String = ""
    public var settings: CellSettings = CellSettings()

    public init(text: String, image: UIImage? = nil, isMultiSelectable: Bool = false, selectionIconType: SelectionIconType = .default) {
        self.identifier = "option_cell_\(image.isNil.toI())_\(selectionIconType) "
        self.text = text
        self.image = image
        self.isMultiSelectable = isMultiSelectable
        self.isSelected = false
        self.selectionIconType = selectionIconType
    }

    public func register(tableView: UITableView) {
        tableView.register(OneLineTextCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? OptionTextCell {
            cell.optionLabel.text = text

            if let image = self.image {
                cell.iconImageView.isHidden = false
                cell.iconImageView.image = image
                cell.iconImageView.snp.makeConstraints { (make) in
                    make.size.equalTo(image.preferredSize)
                }
            } else {
                cell.iconImageView.isHidden = true
                cell.optionLabel.snp.makeConstraints { (make) in
                    make.leading.equalToSuperview().offset(cellContentEdges.left)
                }
            }

            setSelectionIcon(cell: cell)
        }

        return tableCell
    }

    func setSelectionIcon(cell: OptionTextCell) {
        switch selectionIconType {
        case .default:
            cell.accessoryType = isSelected ? .checkmark : .none
            break
        case .checkmark(let tintColor):
            cell.tintColor = tintColor
            cell.accessoryType = isSelected ? .checkmark : .none
            break
        case .image(let image):
            cell.accessoryType = .none
            break
        case .images(let normalImage, let selectedImage):
            break
        }
    }

}

public class OptionTextCell: BuiltInCell {

    public lazy var iconImageView = UIImageView()
    public lazy var optionLabel = UILabel()
    public lazy var selectionImageView = UIImageView()

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(iconImageView)
        contentView.addSubview(optionLabel)
        contentView.addSubview(selectionImageView)

        let margin: CGFloat = .defaultMargin

        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(margin)
        }

        optionLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView).offset(margin)
        }

        selectionImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(optionLabel).offset(margin)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(margin)
            make.trailing.equalToSuperview().offset(-margin)
        }
    }
}
