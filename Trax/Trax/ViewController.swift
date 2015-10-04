//
//  ViewController.swift
//  Trax
//
//  Created by jiaxianhua on 15/10/4.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName(GPXURL.Notification, object: appDelegate, queue: queue) { notification in
            if let url = notification.userInfo?[GPXURL.key] as? NSURL {
                self.textView.text = "Received \(url)"
            }
        }
    }
}

