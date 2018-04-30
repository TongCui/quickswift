//
//  OneImageCellItem.swift
//  QuickSwift
//
//  Created by tcui on 22/12/2017.
//  Copyright © 2017 LuckyTR. All rights reserved.
//

open class LocalImageCellItem: CellItemProtocol {
    public var registerType: TableViewRegisterType = .class(LocalImageCell.self)
    public var identifier: String
    public var cellConfigurator = CellConfigurator()
    public var actionHandler = CellActionHandler()
    public var cellDisplayingContext = CellItemDisplayingContext()

    public var imageName: String
    public var imageHeight: UIImageView.ImageHeight

    public init(imageName: String, imageHeight: UIImageView.ImageHeight) {
        self.identifier = "local_image_cell_\(imageHeight)"
        self.imageName = imageName
        self.imageHeight = imageHeight
    }

    open func bind(cell: UITableViewCell) {
        if let cell = cell as? LocalImageCell {
            cell.selectionStyle = .none
            cell.localImageView.image = UIImage(named: imageName)
            let cellContentEdges = cellConfigurator.cellContentEdges

            cell.localImageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(cellContentEdges.top)
                make.leading.equalToSuperview().offset(cellContentEdges.left)
                make.trailing.equalToSuperview().offset(-cellContentEdges.right)
                make.bottom.equalToSuperview().offset(-cellContentEdges.bottom).priority(.medium)
            }

            cell.localImageView.updateAutolayout(imageHeight: imageHeight)
        }
    }
}

open class LocalImageCell: CommonInitTableCell {

    public lazy var localImageView = UIImageView(image: nil)

    open override func commonInit() {
        super.commonInit()
        contentView.addSubview(localImageView)

        localImageView.backgroundColor = .clear
        localImageView.contentMode = .scaleAspectFill
        localImageView.clipsToBounds = true

    }
}
