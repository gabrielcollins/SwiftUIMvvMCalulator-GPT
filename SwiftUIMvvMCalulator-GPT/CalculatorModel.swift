//
//  CalculatorModel.swift
//  SwiftUIMvvMCalulator-GPT
//
//  Created by Gabriel Alan Collins on 2023-06-10.
//

import Foundation

struct CalculatorModel {
    
    private enum Operation {
        case binaryOperation((Int, Int) -> Int)
        case equals
    }
    
    enum CalculatorError: Error {
        case nonIntegerResult
        case divisionByZero
    }

    private var accumulator: Int?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var lastOperationSymbol: String?

    var errorOccurred = false // flag indicating whether an error occurred
        
    mutating func clearError() {
        errorOccurred = false
    }
    
    private struct PendingBinaryOperation {
        let function: (Int, Int) -> Int
        let firstOperand: Int
    }

    mutating func setOperand(_ operand: Int) {
        accumulator = operand
    }

    var result: Int? {
        get {
            return accumulator
        }
    }

    private var operations: Dictionary<String, Operation> = [
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "−" : Operation.binaryOperation({ $0 - $1 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals,
    ]

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            if symbol != "=" {
                lastOperationSymbol = symbol }
            switch operation {
            
            case .equals:
                do {
                    try performPendingBinaryOperation()
                } catch CalculatorError.nonIntegerResult {
                    errorOccurred = true
                } catch {
                    // Handle any other errors that might occur
                    print("An error occurred: \(error)")
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            }
        }
    }

    private mutating func performPendingBinaryOperation() throws {
        if pendingBinaryOperation != nil && accumulator != nil {
            if lastOperationSymbol == "÷" && pendingBinaryOperation!.firstOperand % accumulator! != 0 {
                throw CalculatorError.nonIntegerResult
            }
            else {
                accumulator = pendingBinaryOperation!.function(pendingBinaryOperation!.firstOperand, accumulator!)
                pendingBinaryOperation = nil
            }
        }
    }


}

