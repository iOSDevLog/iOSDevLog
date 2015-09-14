//
//  CollectionDatasource.swift
//  28
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CollectionDatasource: NSObject, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelSingleton.sharedInstance.dimension
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        // Configure the cell
        let value = ModelSingleton.sharedInstance.tiles[indexPath]
        if (value != nil) {
            cell.configCell("\(value!)")
        }
        else {
            cell.configCell("")
        }
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return ModelSingleton.sharedInstance.dimension
    }
}
