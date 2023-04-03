//
//  PlayerTests.swift
//  Dice36Tests
//
//  Created by Salah Filali on 26/1/2023.
//

import XCTest
@testable import Dice36

final class PlayerTests: XCTestCase {
    
    var sut: Player!
    
    override func setUp() {
        sut = Player(name: "toto", diceResponder: DiceResponder(), gameDelegate: Dice36Game())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testPlayerRollDiceWithResultBetweenOneAndSix() {
        
        //when
        let rolledDiceNumber = sut.rollDice()
        
        //then
        XCTAssertGreaterThanOrEqual(rolledDiceNumber, 1)
        XCTAssertLessThanOrEqual(rolledDiceNumber, 6)
    }

}
