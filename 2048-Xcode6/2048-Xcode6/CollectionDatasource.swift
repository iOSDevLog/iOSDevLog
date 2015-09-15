//
//  CollectionDatasource.swift
//  2048-Xcode6
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CollectionDatasource: NSObject, UICollectionViewDataSource {
    var dimension: Int
    var tiles: Dictionary<NSIndexPath, Int>!
    
    let provider = AppearanceProvider()
    
    init(dimension: Int, tiles: Dictionary<NSIndexPath, Int>) {
        self.dimension = dimension
        self.tiles = tiles
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dimension
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dimension
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        cell.configCell(tiles[indexPath], delegate: provider)
        
        return cell
    }
}
