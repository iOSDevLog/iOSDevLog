//
//  TableViewCell.swift
//  selfSizingCells
//
//  Created by iosdevlog on 15/12/8.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var pxImageView: UIImageView!
    
    @IBOutlet weak var pxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
