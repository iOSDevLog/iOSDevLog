//
//  NumberTileGameViewController.swift
//  2048-Xcode6
//
//  Created by JiaXianhua on 15/9/14.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

import UIKit

class NumberTileGameViewController: UIViewController, GameModelProtocol {
    // How many tiles in both directions the gameboard contains
    var dimension: Int {
        didSet {
            collectionDatasource = CollectionDatasource(dimension: dimension, tiles: tiles)
            newGame()
            collectionView.reloadData()
            switch dimension {
            case 3:
                threshold = 1024
            case 4:
                threshold = 2048
            case 5:
                threshold = 4096
            default:
                threshold = 2048
            }
        }
    }
    
    // The value of the winning tile
    var threshold: Int {
        didSet {
            targetLabel.text = "Target: \(threshold)"
        }
    }
    
    var model: GameModel?
    
    var tiles: Dictionary<NSIndexPath, Int>! {
        didSet {
            collectionDatasource.tiles = tiles
            collectionView.reloadData()
        }
    }
    
    var collectionDatasource: CollectionDatasource!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: init & viewDidLoad
    required init(coder aDecoder: NSCoder) {
        dimension = 4
        threshold = 2048
        tiles = Dictionary<NSIndexPath, Int>()
        collectionDatasource = CollectionDatasource(dimension: dimension, tiles: tiles)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        segmentedControl.selectedSegmentIndex = 1
        newGame()
    }
    
    // MARK: - new Game
    @IBAction func newGame(sender: UIButton) {
        newGame()
    }
    
    // MARK: - changeDimension
    @IBAction func changeDimension(sender: UISegmentedControl) {
        dimension = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)?.toInt()! ?? 4
    }
    
    // MARK: - SwipeGestureRecognizer
    @IBAction func up(sender: UISwipeGestureRecognizer) {
        assert(model != nil)
        let m = model!
        m.queueMove(MoveDirection.Up,
            completion: {
                (changed: Bool) -> () in
                if changed {
                    self.followUp()
                }
        })
    }
    
    @IBAction func down(sender: UISwipeGestureRecognizer) {
        assert(model != nil)
        let m = model!
        m.queueMove(MoveDirection.Down,
            completion: {
                (changed: Bool) -> () in
                if changed {
                    self.followUp()
                }
        })
    }
    
    @IBAction func left(sender: UISwipeGestureRecognizer) {
        assert(model != nil)
        let m = model!
        m.queueMove(MoveDirection.Left,
            completion: {
                (changed: Bool) -> () in
                if changed {
                    self.followUp()
                }
        })
    }
    
    @IBAction func right(sender: UISwipeGestureRecognizer) {
        assert(model != nil)
        let m = model!
        m.queueMove(MoveDirection.Right,
            completion: {
                (changed: Bool) -> () in
                if changed {
                    self.followUp()
                }
        })
    }
    
    func reset() {
        tiles.removeAll(keepCapacity: true)
        let m = model!
        m.reset()
        m.insertTileAtRandomLocation(2)
        m.insertTileAtRandomLocation(2)
    }
    
    /// Return whether a given position is valid. Used for bounds checking.
    func positionIsValid(pos: (Int, Int)) -> Bool {
        let (x, y) = pos
        return (x >= 0 && x < dimension && y >= 0 && y < dimension)
    }
    
    
    // MARK: GameModelProtocol
    func scoreChanged(score: Int) {
        scoreView.score = score
    }
    
    /// Update the gameboard by moving a single tile from one location to another. If the move is going to collapse two
    /// tiles into a new tile, the tile will 'pop' after moving to its new location.
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        assert(positionIsValid(from) && positionIsValid(to))
        let (fromRow, fromCol) = from
        let (toRow, toCol) = to
        let fromKey = NSIndexPath(forRow: fromRow, inSection: fromCol)
        let toKey = NSIndexPath(forRow: toRow, inSection: toCol)
        
        // Get the tiles
        assert(tiles[fromKey] != nil)
        var tile = tiles[fromKey]!
        let endTile = tiles[toKey]
        
        // Update board state
        tiles.removeValueForKey(fromKey)
        tile = value
        tiles[toKey] = tile
        
        tile = value
    }
    
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        assert(positionIsValid(from.0) && positionIsValid(from.1) && positionIsValid(to))
        let (fromRowA, fromColA) = from.0
        let (fromRowB, fromColB) = from.1
        let (toRow, toCol) = to
        let fromKeyA = NSIndexPath(forRow: fromRowA, inSection: fromColA)
        let fromKeyB = NSIndexPath(forRow: fromRowB, inSection: fromColB)
        let toKey = NSIndexPath(forRow: toRow, inSection: toCol)
        
        assert(tiles[fromKeyA] != nil)
        assert(tiles[fromKeyB] != nil)
        var tileA = tiles[fromKeyA]!
        var tileB = tiles[fromKeyB]!
        
        tiles.removeValueForKey(fromKeyA)
        tiles.removeValueForKey(fromKeyB)
        tiles[toKey] = value
    }
    
    func insertTile(location: (Int, Int), value: Int) {
        let (row, col) = location
        tiles[NSIndexPath(forRow: row, inSection: col)] = value
    }
    
    func newGame() {
        (collectionView.collectionViewLayout as! CollectionViewFlowLayout).configItemsize(CGFloat(dimension))
        collectionView.dataSource = collectionDatasource
        model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
        
        reset()
    }
    
    // Misc
    func followUp() {
        assert(model != nil)
        let m = model!
        let (userWon, winningCoords) = m.userHasWon()
        if userWon {
            // TODO: alert delegate we won
            let alertView = UIAlertView()
            alertView.title = "Victory"
            alertView.message = "You won!"
            alertView.addButtonWithTitle("OK")
            alertView.show()
            // TODO: At this point we should stall the game until the user taps 'New Game' (which hasn't been implemented yet)
            return
        }
        
        // Now, insert more tiles
        let randomVal = Int(arc4random_uniform(10))
        m.insertTileAtRandomLocation(randomVal == 1 ? 4 : 2)
        
        // At this point, the user may lose
        if m.userHasLost() {
            let alertView = UIAlertView()
            alertView.title = "Defeat"
            alertView.message = "You lost..."
            alertView.addButtonWithTitle("Cancel")
            alertView.show()
        }
    }
}
