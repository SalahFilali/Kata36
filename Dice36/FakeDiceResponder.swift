//
//  FakeDiceResponder.swift
//  Dice36
//
//  Created by Salah Filali on 26/1/2023.
//

import Foundation

class FakeDiceResponder: DiceResponder {
    public override func rollDice() -> Int {
        return 6
    }
}
