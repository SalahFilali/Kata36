//
//  Player.swift
//  Dice36
//
//  Created by Salah Filali on 26/1/2023.
//

import Foundation

public class Player {
    
    private(set) var name: String
    private var diceResponder: DiceResponder
    private var gameDelegate: GameDelegate
    
    init(name: String, diceResponder: DiceResponder, gameDelegate: GameDelegate) {
        self.name = name
        self.diceResponder = diceResponder
        self.gameDelegate = gameDelegate
    }
    
    func rollDice() -> Int {
        let diceResult = diceResponder.rollDice()
        gameDelegate.addDiceResultToScore(diceResult, from: self)
        return diceResult
    }
}
