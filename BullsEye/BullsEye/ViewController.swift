//
//  ViewController.swift
//  BullsEye
//
//  Created by iosdevlog on 15/12/15.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        print("The value of the slider is now: \(sender.value)")
    }
    
    @IBAction func showAlert(sender: UIButton) {
        let alert = UIAlertController(title: "Hello, World!", message: "This is my first app!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Awesome", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true) { () -> Void in
            print("You Hit Me!")
        }
    }
    
}

