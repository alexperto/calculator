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
    var brain = BrainCalculator()

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
    

    @IBAction func enter() {
        isUserInTheMiddleOfTypping = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else {
            displayValue = 0
        }
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
        if isUserInTheMiddleOfTypping{
            enter()
        }
        if let symbol = sender.currentTitle {
            if let result = brain.performOperation(symbol){
                displayValue = result
            }else{
                displayValue = 0
            }
        }

    }
    
}

