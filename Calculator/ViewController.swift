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
                resultLabel.text = String(M_PI)
            } else if "e" == operation {
                resultLabel.text = String(M_E)
            }
        }
    }

}
