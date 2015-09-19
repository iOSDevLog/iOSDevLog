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
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
            case "×":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() * operandStack.removeLast()
                    enter()
            }
//        case "÷":
//        case "+":
//        case "−":
        default:
            break
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

