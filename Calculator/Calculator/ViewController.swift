//
//  ViewController.swift
//  Calculator
//
//  Created by jiaxianhua on 15/9/18.
//  Copyright (c) 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userIsInTheMiddleOfTypingANumber: Bool = false
    @IBOutlet weak var display: UILabel!
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle
        if userIsInTheMiddleOfTypingANumber {
            
            display.text = display.text! + "\(digit!)"
        }
        else {
            display.text = "\(digit!)"
            userIsInTheMiddleOfTypingANumber = true
        }
    }
}

