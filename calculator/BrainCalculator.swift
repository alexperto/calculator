//
//  BrainCalculator.swift
//  calculator
//
//  Created by alex cabrera on 3/19/15.
//  Copyright (c) 2015 alex cabrera. All rights reserved.
//

import Foundation

class BrainCalculator {
    private var operandStack = [Op]()
    private var knowOperands = [String:Op]()

    private enum Op{
      case Operand(Double)
      case UnaryOperation(String, Double -> Double)
      case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    init(){
        knowOperands["+"] = Op.BinaryOperation("+", + )
        knowOperands["−"] = Op.BinaryOperation("−") { $1 - $0 }
        knowOperands["×"] = Op.BinaryOperation("×", * )
        knowOperands["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knowOperands["√"] = Op.UnaryOperation("√", sqrt )
    }
    
    func pushOperand(op:Double) -> Double? {
      operandStack.append(Op.Operand(op))
      return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        if let op = knowOperands[symbol] {
            operandStack.append(op)
        }
        return evaluate()
    }
    
    func evaluate() -> Double? {
        let (result, remindingOps) = evaluate(operandStack)
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remandingOps: [Op] ){
        if !ops.isEmpty{
            var remindingOps = ops
            let op = remindingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return ( operand, remindingOps)
            case .UnaryOperation( _ , let operation ):
                let operandEvaluation = evaluate(remindingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remandingOps)
                }
            case .BinaryOperation( _ , let operation ):
                let operand1Evaluation = evaluate(remindingOps)
                if let operand1 = operand1Evaluation.result{
                    let operand2Evaluation = evaluate(operand1Evaluation.remandingOps)
                    if let operand2 = operand2Evaluation.result{
                        return (operation(operand1, operand2), operand2Evaluation.remandingOps)
                    }
                }
            }
            
        }
        return(nil, ops)
    }
}