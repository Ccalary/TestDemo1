//
//  Calculator.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/8.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class Calculator {
    
    func start() -> String {
        
        /// 界面数据
        let a = arc4random()%100
        let b = arc4random()%100
        let operateArray = ["+", "-", "*", "/"]
        let operate = operateArray[Int(arc4random())%4]
        
        /// 只要下面这几行代码就可以实现逻辑处理
        let operation = OperationFactory.createOperation(operate)
        operation?.numberA = Double(a)
        operation?.numberB = Double(b)
        let result = operation?.getResult()
        
        let log = "数值A:\(a)\n数值B:\(b)\n操作符:\(operate)\n结果:\(String(describing: result))"
        print(log)
        return log
    }
}

/// 简单工厂方法，根据计算符得出需要哪个计算类
/// 你只需要输入运算符号，工厂就实例化出合适的对象，通过多态，返回父类的方式实现了计算器的结果。”
class OperationFactory {
    static func createOperation(_ operate: String) -> Operation? {
        var operation: Operation? = nil
        switch operate {
        case "+":
            operation = OpeationAdd()
        case "-":
            operation = OpeationSub()
        case "*":
            operation = OpeationMul()
        case "/":
            operation = OpeationDiv()
        default:
            operation = nil
        }
        return operation
    }
}

protocol Calculate {
    func getResult() -> Double
}

class Operation: Calculate {
    
    private var _numberA: Double = 0.0
    private var _numberB: Double = 0.0
    
    public var numberA: Double {
        get {
           return _numberA
        }
        set {
            _numberA = newValue
        }
    }
    
    public var numberB: Double {
        get {
           return _numberB
        }
        set {
            _numberB = newValue
        }
    }
    
    func getResult() -> Double {
        /// 子类实现具体的方式，这里直接提示错误
        fatalError("getResult() cannot be called on Operation")
    }
}

class OpeationAdd: Operation {
    override func getResult() -> Double {
        return numberA + numberB
    }
}

class OpeationSub: Operation {
    override func getResult() -> Double {
        return numberA - numberB
    }
}

class OpeationMul: Operation {
    override func getResult() -> Double {
        return numberA * numberB
    }
}

class OpeationDiv: Operation {
    override func getResult() -> Double {
        if numberB == 0 {
            fatalError("除数不能为0")
        }
        return numberA / numberB
    }
}


