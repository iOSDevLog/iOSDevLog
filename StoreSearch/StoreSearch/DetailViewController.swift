//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by iosdevlog on 16/2/27.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - lifeCycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - action
    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: -
extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController,
        presentingViewController presenting: UIViewController,
        sourceViewController source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}

