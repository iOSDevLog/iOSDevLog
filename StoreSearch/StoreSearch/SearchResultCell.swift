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
        
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
}
