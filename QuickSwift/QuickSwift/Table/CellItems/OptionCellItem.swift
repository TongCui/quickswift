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
    public var textIconSpace: CGFloat = .defaultMargin
    public var isMultiSelectable: Bool
    public var isSelected: Bool
    public var selectionIconType: SelectionIconType
    public var identifier: String = ""
    public var settings: CellSettings = CellSettings()

    public init(text: String, image: UIImage? = nil, isMultiSelectable: Bool = false, selectionIconType: SelectionIconType = .default) {
        self.identifier = "option_cell_image\(image.isNil.toI())_\(selectionIconType) "
        self.text = text
        self.image = image
        self.isMultiSelectable = isMultiSelectable
        self.isSelected = false
        self.selectionIconType = selectionIconType
        cellHeight = .automaticDimension
    }

    public func register(tableView: UITableView) {
        tableView.register(OptionTextCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? OptionTextCell {
            cell.optionLabel.text = text
            print("\(self.identifier) - \(indexPath)")
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
        case .checkmark(let tintColor):
            cell.tintColor = tintColor
            cell.accessoryType = isSelected ? .checkmark : .none
        case .image(let image):
            cell.accessoryType = .none
            cell.selectionImageView.image = isSelected ? image : nil
            cell.selectionImageView.updateToPreferred(image)
        case .images(let normalImage, let selectedImage):
            let image = isSelected ? selectedImage : normalImage;
            cell.selectionImageView.image = image
            cell.selectionImageView.updateToPreferred(image)
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
