//
//  ViewController.swift
//  calculator
//
//  Created by alex cabrera on 3/12/15.
//  Copyright (c) 2015 alex cabrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isUserInTheMiddleOfTypping:Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInTheMiddleOfTypping {
            display.text = display.text! + digit
        }else{
            display.text = digit
            isUserInTheMiddleOfTypping = true
        }
        println("append: \(digit)")
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter() {
        isUserInTheMiddleOfTypping = false
        operandStack.append(displayValue)
        println("stack: \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            isUserInTheMiddleOfTypping = false
        }
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if isUserInTheMiddleOfTypping{
            enter()
        }
        switch operation{
          case "+": performOperation{ $0 + $1 }
          case "−": performOperation{ $1 - $0 }
          case "×": performOperation{ $0 * $1 }
          case "÷": performOperation{ $1 / $0 }
          case "√": performOperation{ sqrt($0) }
          default : break
        }
    }
    
    func performOperation(operation:(Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
          displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
          enter()
        }
    }

}

