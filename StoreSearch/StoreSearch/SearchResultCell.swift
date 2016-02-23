//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/23.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    // MARK: - outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    // MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
