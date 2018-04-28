//
//  FontTextStylesViewController.swift
//  Example
//
//  Created by tcui on 14/3/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import QuickSwift

final class FontStylesAdapter: DefaultTableAdapter {
    
    required init() {
        super.init()

        let sectionItem = PlainSectionItem()
        
        let fontStyles: [(UIFontTextStyle, String)] = [
            (.body, "The font used for body text."),
            (.callout, "The font used for callouts."),
            (.caption1, "The font used for standard captions."),
            (.caption2, "The font used for alternate captions."),
            (.footnote, "The font used in footnotes."),
            (.headline, "The font used for headings."),
            (.subheadline, "The font used for subheadings."),
            (.largeTitle, "The font style for large titles."),
            (.title1, "The font used for first level hierarchical headings."),
            (.title2, "The font used for second level hierarchical headings."),
            (.title3, "The font used for third level hierarchical headings.")
        ]
        
        let cellItems = fontStyles.map { (arg) -> CellItemProtocol in
            let (style, comment) = arg
            return OneLineTextCellItem(text: "\(style)\n----\n\(comment)").customUI { (cell) in
                if let cell = cell as? OneLineTextCell {
                    cell.oneLineLabel.font = UIFont.preferredFont(forTextStyle: style)
                }
            }
        }
        
        sectionItem.append { cellItems }
        append(sectionItem: sectionItem)
        
    }
    
}


final class FontTextStylesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var adapter = FontStylesAdapter(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.reloadData()
    }
}
