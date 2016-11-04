//
//  ViewController.swift
//  Calculator
//
//  Created by Nicole on 01.11.16.
//  Copyright © 2016 IchHabRecht Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Displays the result of the calculation
    @IBOutlet private weak var resultLabel: UILabel!
    
    // Displays the sequence of the calculation
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // Stores if the user started to enter a digit
    private var userAlreadyTouchedDigit = false;
    
    // Use computed property to get and set the resultLabel
    private var displayResult: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    // Adds the current touched digit to label
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userAlreadyTouchedDigit {
            resultLabel.text = resultLabel.text! + digit
        } else {
            resultLabel.text = digit
            userAlreadyTouchedDigit = true
        }
    }
    
    // Performs an operation and shows result in label
    @IBAction private func performOperation(_ sender: UIButton) {
        userAlreadyTouchedDigit = false
        if let operation = sender.currentTitle {
            if "π" == operation {
                displayResult = M_PI
            } else if "e" == operation {
                displayResult = M_E
            } else if "√" == operation {
                displayResult = sqrt(displayResult)
            }
        }
    }

}
