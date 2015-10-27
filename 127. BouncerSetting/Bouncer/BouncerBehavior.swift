//
//  BouncerBehavior.swift
//  Bouncer
//
//  Created by jiaxianhua on 15/10/5.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

import UIKit

// mostly stolen from Dropit
// since Bouncer's behavior is very similar to Dropit's
// but changed "drop" terminology to "block"

class BouncerBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
        }()
    
    lazy var blockBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBlockBehavior = UIDynamicItemBehavior()
        lazilyCreatedBlockBehavior.allowsRotation = true
        
        lazilyCreatedBlockBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("BouncerBehavior.Elasticity"))
        lazilyCreatedBlockBehavior.friction = 0
        lazilyCreatedBlockBehavior.resistance = 0
        NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification, object: nil, queue: nil, usingBlock: { (notifaction) -> Void in
            lazilyCreatedBlockBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("BouncerBehavior.Elasticity"))
        })
        
        return lazilyCreatedBlockBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(blockBehavior)
    }
    
    func addBlock(block: UIView) {
        dynamicAnimator?.referenceView?.addSubview(block)
        gravity.addItem(block)
        collider.addItem(block)
        blockBehavior.addItem(block)
    }
    
    func removeBlock(block: UIView) {
        gravity.removeItem(block)
        collider.removeItem(block)
        blockBehavior.removeItem(block)
        block.removeFromSuperview()
    }
}