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
        case "×": performOperation({ (op1: Double, op2: Double) -> Double in
            return op1 * op2
        })
//        case "÷":
//        case "+":
//        case "−":
        default:
            break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
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

