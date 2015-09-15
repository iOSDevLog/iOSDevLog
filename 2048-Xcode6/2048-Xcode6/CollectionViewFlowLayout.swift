//
//  CollectionViewFlowLayout.swift
//  2048-Xcode6
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    func configItemsize(dimension: CGFloat) {
        var collectionViewWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        var totalCellWidth = collectionViewWidth - minimumInteritemSpacing * (CGFloat(dimension) + 1)
        var cellWidth = totalCellWidth / CGFloat(dimension)
        
        itemSize = CGSizeMake(cellWidth, cellWidth)
    }
}
