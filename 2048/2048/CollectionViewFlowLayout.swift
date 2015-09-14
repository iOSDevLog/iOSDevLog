//
//  CollectionViewFlowLayout.swift
//  28
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    func configItemsize(dimension: CGFloat) {
        let collectionViewWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let totalCellWidth = collectionViewWidth - minimumInteritemSpacing * (CGFloat(dimension) + 1)
        let cellWidth = totalCellWidth / CGFloat(dimension)
        
        itemSize = CGSizeMake(cellWidth, cellWidth)
    }
}
