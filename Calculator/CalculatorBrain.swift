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
        "x²": Operation.UnaryOperation({ pow($0, 2) }),
        "√": Operation.UnaryOperation(sqrt),
        "±": Operation.UnaryOperation({ -$0 }),
        "xʸ": Operation.BinaryOperation({ pow($0, $1) }),
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
    
    // Property to store the description of operations
    private var sequence = " "
    
    // Read-only property for description
    var description: String {
        get {
            return sequence
        }
    }
    
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
                sequence = symbol
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
