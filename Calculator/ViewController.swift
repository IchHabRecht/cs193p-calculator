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

}
