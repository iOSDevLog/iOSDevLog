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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - action
    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
