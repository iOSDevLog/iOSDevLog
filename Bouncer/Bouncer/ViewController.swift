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
    
    
}

