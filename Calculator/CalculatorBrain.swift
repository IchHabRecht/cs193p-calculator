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
        case UnaryOperation((Double) -> Double, (String) -> String)
        case BinaryOperation((Double, Double) -> Double, (String, String) -> String)
        case NullaryOperation(() -> Double, String)
        case Equals
    }
    
    // Dictionary of supported operations
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "x²": Operation.UnaryOperation({ pow($0, 2) }, { $0 + "²" }),
        "√": Operation.UnaryOperation(sqrt, { "√(" + $0 + ")" }),
        "±": Operation.UnaryOperation({ -$0 }, { "-(" + $0 + ")" }),
        "xʸ": Operation.BinaryOperation({ pow($0, $1) }, { $0 + " ^ " + $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }, { $0 + " + " + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }, { $0 + " − " + $1 }),
        "×": Operation.BinaryOperation({ $0 * $1 }, { $0 + " × " + $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }, { $0 + " ÷ " + $1 }),
        "rand": Operation.NullaryOperation(drand48, "rand()"),
        "=": Operation.Equals
    ]
    
    // Struct to store a binary operation
    private struct PendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var operand: Double
        var binaryFunctionDescription: (String, String) -> String
        var sequence: String
    }
    
    // Property to store the pending operation
    private var pendingOperation: PendingBinaryOperation?
    
    // Property to store the description of operations
    private var sequence = " "
    
    // Read-only property for description
    var description: String {
        get {
            if nil == pendingOperation {
                return sequence
            } else {
                let operationSequence = pendingOperation!.sequence
                return pendingOperation!.binaryFunctionDescription(operationSequence, operationSequence != sequence ? sequence : "")
            }
        }
    }
    
    // Returns true if a pending operation is available
    var isPartialResult: Bool {
        get {
            return nil != pendingOperation
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
        sequence = String(format: "%g", operand)
    }
    
    // Performs the operation and stores the result
    func performOperation (symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let constant):
                accumulator = constant
                sequence = symbol
            case .UnaryOperation(let function, let functionDescription):
                accumulator = function(accumulator)
                sequence = functionDescription(sequence)
            case .BinaryOperation(let function, let functionDescription):
                executePendingOperation()
                pendingOperation = PendingBinaryOperation(binaryFunction: function, operand: accumulator, binaryFunctionDescription: functionDescription, sequence: sequence)
            case .NullaryOperation(let function, let description):
                accumulator = function()
                sequence = description
            case .Equals:
                executePendingOperation()
            }
        }
    }
    
    // Execute a pending oparation
    private func executePendingOperation() {
        if nil != pendingOperation {
            accumulator = pendingOperation!.binaryFunction(pendingOperation!.operand, accumulator)
            sequence = pendingOperation!.binaryFunctionDescription(pendingOperation!.sequence, sequence)
            pendingOperation = nil
        }
    }
    
}
