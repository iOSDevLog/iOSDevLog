//
//  CollectionViewCell.swift
//  28
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func configCell(score: String) {
        scoreLabel.text = score
        self.layer.cornerRadius = 5;
    }
}
