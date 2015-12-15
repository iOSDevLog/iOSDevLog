//
//  ViewController.swift
//  BullsEye
//
//  Created by iosdevlog on 15/12/15.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 1

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startNewRound()
        updateLabels()
    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func showAlert(sender: UIButton) {
        var difference: Int
        
        if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        }
        
        
        let message = "The value of the slider is: \(currentValue)"
                + "\nThe target value is: \(targetValue)"
                + "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: "Hello, World!", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true) { () -> Void in
            print("You Hit Me!")
        }
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = lroundf(slider		.value)
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
            targetLabel.text = String(targetValue)
    }
}

