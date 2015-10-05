//
//  ViewController.swift
//  Bouncer
//
//  Created by jiaxianhua on 15/10/5.
//  Copyright © 2015年 iOSDevLog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let bouncer = BouncerBehavior()
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }
    
    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zero, size: Constants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(block)
        return block
    }
}

