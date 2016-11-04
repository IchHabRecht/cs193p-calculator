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
    
    // Types of possible operations
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    // Dictionary of supported operations
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "=": Operation.Equals
    ]
    
    // Struct to store a binary operation
    private struct PendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var operand: Double
    }
    
    // Property to store the pending operation
    private var pendingOperation: PendingBinaryOperation?
    
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
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let constant):
                accumulator = constant
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pendingOperation = PendingBinaryOperation(binaryFunction: function, operand: accumulator)
            case .Equals:
                executePendingOperation()
            }
        }
    }
    
    // Execute a pending oparation
    private func executePendingOperation() {
        if nil != pendingOperation {
            accumulator = pendingOperation!.binaryFunction(pendingOperation!.operand, accumulator)
            pendingOperation = nil
        }
    }
    
}
