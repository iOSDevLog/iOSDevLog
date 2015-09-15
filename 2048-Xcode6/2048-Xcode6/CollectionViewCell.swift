//
//  CollectionViewCell.swift
//  2048-Xcode6
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    var tileMergeStartScale: NSTimeInterval = 1.0
    let tilePopMinScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
    var duration: NSTimeInterval = 0.2
    
    func configCell(value: Int?, delegate d: AppearanceProviderProtocol) {
        var number: Int = 9
        if let v = value {
            number = v
        }
        valueLabel.text = "\(number)"
        valueLabel.font = d.fontForNumbers()
        self.layer.cornerRadius = 5;
        self.backgroundColor = d.tileColor(number)
        valueLabel.textColor = d.numberColor(number)
        
        self.valueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(self.tilePopMinScale, self.tilePopMinScale))
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.valueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(self.tilePopMaxScale, self.tilePopMaxScale))
        })
    }
}
