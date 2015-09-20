//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by jiaxianhua on 15/9/20.
//  Copyright (c) 2015年 com.jiaxh. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    var opStack = [Op]()
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
}