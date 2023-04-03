//
//  DiceResponder.swift
//  Dice36
//
//  Created by Salah Filali on 26/1/2023.
//

import Foundation

public protocol DiceResponderProtocol {
    func rollDice() -> Int
}


public class DiceResponder: DiceResponderProtocol {
    
    public func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
}
