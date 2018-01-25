//
//  OneImageCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

public class LocalImageCellItem: CellItemProtocol {
    public var imageName: String
    private let edgeInsets: UIEdgeInsets
    public var imageHeight: UIImageView.ImageHeight
    public var identifier: String
    public var settings: CellSettings = CellSettings()

    public convenience init(imageName: String, imageHeight: UIImageView.ImageHeight, margin: CGFloat) {
        self.init(imageName: imageName, imageHeight: imageHeight, edgeInsets: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
    }

    public init(imageName: String, imageHeight: UIImageView.ImageHeight, edgeInsets: UIEdgeInsets) {
        self.identifier = "local_image_cell_\(imageHeight) "
        self.imageName = imageName
        self.edgeInsets = edgeInsets
        self.imageHeight = imageHeight
        cellHeight = .automaticDimension
    }

    public func register(tableView: UITableView) {
        tableView.register(LocalImageCell.self, forCellReuseIdentifier: identifier)
    }

    public func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let cell = tableCell as? LocalImageCell {
            cell.selectionStyle = .none
            cell.localImageView.image = UIImage(named: imageName)
            cell.localImageView.snp.updateConstraints { (make) in
                make.edges.equalToSuperview().inset(edgeInsets)
            }

            cell.localImageView.updateAutolayout(imageHeight: imageHeight)
        }

        return tableCell
    }
}

public class LocalImageCell: BuiltInCell {

    public lazy var localImageView = UIImageView(image: nil)

    public override func commonInit() {
        super.commonInit()
        contentView.addSubview(localImageView)

        localImageView.backgroundColor = .clear
        localImageView.contentMode = .scaleAspectFill
        localImageView.clipsToBounds = true

        localImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
