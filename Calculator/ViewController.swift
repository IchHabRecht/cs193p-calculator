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
    
    // Property for CalculatorBrain instance
    private var brain = CalculatorBrain()
    
    // Use computed property to get and set the resultLabel
    private var displayResult: Double? {
        get {
            // Try to convert the text to a Double
            if let number = resultLabel.text, let value = NumberFormatter().number(from: number)?.doubleValue {
                return value
            }
            return nil
        }
        set {
            if let value = newValue {
                // Format value as a decimal with 6 digits after floating point
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 6
                resultLabel.text = formatter.string(from: NSNumber(value: value))
                descriptionLabel.text = brain.description + (brain.isPartialResult ? " ..." : " =")
            } else {
                userAlreadyTouchedDigit = false
                resultLabel.text = "0"
                descriptionLabel.text = " "
            }
        }
    }
    
    // Adds the current touched digit to label
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentResultLabel = resultLabel.text!
        // Add floating point to result label
        if "." == digit {
            if userAlreadyTouchedDigit {
                // Only if no floting point available
                if !currentResultLabel.contains(".") {
                    resultLabel.text = resultLabel.text! + digit
                }
            } else {
                // Initialize the label
                resultLabel.text = "0."
                userAlreadyTouchedDigit = true
            }
        } else if userAlreadyTouchedDigit && "0" != currentResultLabel {
            // Prevent multiple leading zeros
            resultLabel.text = resultLabel.text! + digit
        } else {
            resultLabel.text = digit
            userAlreadyTouchedDigit = true
        }
    }
    
    // Performs an operation and shows result in label
    @IBAction private func performOperation(_ sender: UIButton) {
        if userAlreadyTouchedDigit {
            brain.setOperand(operand: displayResult!)
            userAlreadyTouchedDigit = false
        }
        if let operation = sender.currentTitle {
            brain.performOperation(symbol: operation)
        }
        displayResult = brain.result
    }

    // Reset the calculator
    @IBAction func clearDisplay(_ sender: UIButton) {
        if "AC" == sender.currentTitle {
            displayResult = nil
            brain = CalculatorBrain()
        } else if userAlreadyTouchedDigit {
            // Implement a backspace button if the user already started typing
            if var currentResultLabel = resultLabel.text {
                // Remove the last character
                currentResultLabel.remove(at: currentResultLabel.index(before: currentResultLabel.endIndex))
                if currentResultLabel.isEmpty {
                    // Reset label if empty
                    currentResultLabel = "0"
                    userAlreadyTouchedDigit = false
                }
                resultLabel.text = currentResultLabel
            }
        }
    }
    
}
