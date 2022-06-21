//
//  Test.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/5/17.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

class Test: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let dice = Dice(sides: 1, generator: LinearCongruentialGenerator())
        dice.roll()
        
        let dice2 = Dice(sides: 3, generator: LinearCongruentialGenerator())
        dice2.roll()
            
        print("\(dice.generator.random())")
        
        if let gen = dice.generator as? LinearCongruentialGenerator {
            let result = gen.randomBool()
            print("\(result)")
        }
        
        if (dice != dice2) {
            print("!=")
        }else {
            print("==")
        }
    }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

extension RandomNumberGenerator {
    func randomBool() -> Bool{
        return random() > 10
    }
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

extension Dice: Equatable {
    static func == (lhs: Dice, rhs: Dice) -> Bool {
        return lhs.sides == rhs.sides
    }
    
//    static func != (lhs: Dice, rhs: Dice) -> Bool {
//        return lhs.sides != rhs.sides
//    }
}
 
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
    
    func randomBool() -> Bool{
        return random() < 5
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice: Dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    var delegate: DiceGameDelegate?
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let dicRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: dicRoll)
            switch square + dicRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += dicRoll
                square += board[square]
            }
            
        }
        delegate?.gameDidEnd(self)
    }
}

extension Int {
    mutating func repetition(task: () -> Void) {
        for _ in 0...self {
            task()
        }
    }
}

extension Array {
    func allEqual1(_ compare: (Element, Element) -> Bool) -> Bool {
        guard let first = first else {
            return true
        }
        for element in dropFirst() {
            guard compare(first, element) else {
                return false
            }
        }
        return true
    }
    
    func allEqual(_ compare: Eq<Element>) -> Bool {
        guard let first = first else {
            return true
        }
        for element in dropFirst() {
            guard compare.eq(first, element) else {
                return false
            }
        }
        return true
    }
}

struct Eq<A> {
    let eq: (A, A) -> Bool
}

extension Eq {
    func notEqual(_ l: A, _ r: A) -> Bool {
        return !eq(l,r)
    }
}

