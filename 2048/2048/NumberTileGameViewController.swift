//
//  NumberTileGameViewController.swift
//  28
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class NumberTileGameViewController: UIViewController, GameModelProtocol {
    // How many tiles in both directions the gameboard contains
    var dimension: Int
    // The value of the winning tile
    var threshold: Int
    
    var scoreView: ScoreViewProtocol?
    
    var collectionDatasource = CollectionDatasource()
    
//    var tiles: Dictionary<NSIndexPath, Int>
    var model: GameModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        dimension = 4
        threshold = 2048
        super.init(coder: aDecoder)
    }
    
    // MARK 
    
    func scoreChanged(score: Int) {
        
    }
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        
    }
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        
    }
    func insertTile(location: (Int, Int), value: Int) {
        let (row, col) = location
        ModelSingleton.sharedInstance.tiles[NSIndexPath(forRow: row, inSection: col)] = value
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        (collectionView.collectionViewLayout as! CollectionViewFlowLayout).configItemsize(CGFloat(dimension))
        collectionView.dataSource = collectionDatasource
        model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
        
        setupGame()
    }
    
    @IBAction func up(sender: UISwipeGestureRecognizer) {
        print("\(sender)")
    }
    @IBAction func down(sender: UISwipeGestureRecognizer) {
        print("\(sender)")
    }
    @IBAction func left(sender: UISwipeGestureRecognizer) {
        print("\(sender)")
    }
    @IBAction func right(sender: UISwipeGestureRecognizer) {
        print("\(sender)")
    }
    
    func setupGame() {
        assert(model != nil)
        let m = model!
        m.insertTileAtRandomLocation(2)
        m.insertTileAtRandomLocation(2)
    }
}
