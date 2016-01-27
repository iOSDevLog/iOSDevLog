//
//  FirstViewController.swift
//  MyLocations
//
//  Created by iosdevlog on 16/1/27.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import UIKit

class CurrentLocationViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getLocation(sender: UIButton) {
    }
}

