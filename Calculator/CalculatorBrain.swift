//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Nicole on 04.11.16.
//  Copyright © 2016 IchHabRecht Inc. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // Property to store accumulated results
    private var accumulator = 0.0
    
    // Read-only property for operation result
    var result: Double {
        get {
            return accumulator
        }
    }
    
    // Sets the accumulator
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    // Performs the operation and stores the result
    func performOperation (symbol: String) {
        if "π" == symbol {
            accumulator = M_PI
        } else if "e" == symbol {
            accumulator = M_E
        } else if "√" == symbol {
            accumulator = sqrt(accumulator)
        }
    }
    
}
