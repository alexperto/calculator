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
}

