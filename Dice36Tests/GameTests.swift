//
//  GameTests.swift
//  Dice36Tests
//
//  Created by Salah Filali on 26/1/2023.
//

import XCTest
@testable import Dice36

final class GameTests: XCTestCase {

    var sut: Dice36Game!
    
    override func setUp() {
        sut = Dice36Game()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testNewGameScoreEqualsZero() {
        //given//when
        sut = Dice36Game()

        //then
        XCTAssertEqual(sut.score, 0)
    }
    
    func testAddPlayerToNewGame() {
        //given
        sut = Dice36Game()

        //when
        let newPlayer = Player(name: "Toto", diceResponder: DiceResponder(), gameDelegate: sut)
        sut.addPlayer(newPlayer)

        //then
        XCTAssertEqual(sut.players[0].name, newPlayer.name)
    }

    func testGameStatusWhenAddinngPlayerToGame() {
        //given
        sut = Dice36Game()

        //when
        let newPlayer = Player(name: "Toto", diceResponder: DiceResponder(), gameDelegate: sut)
        sut.addPlayer(newPlayer)

        //then
        XCTAssertEqual(sut.status, .gatheringPlayers)
    }
    
    func testGameStatusWhenGameStarted() {
        //given
        sut = Dice36Game()

        //when
        sut.startGame()

        //then
        XCTAssertEqual(sut.status, .gameStarted)
    }
    
    func testAddNewPlayerWhenGameAlreadyStarted() {
        //given
        sut = Dice36Game()
        sut.addPlayer(Player(name: "first Player", diceResponder: DiceResponder(), gameDelegate: sut))
        sut.addPlayer(Player(name: "second Player", diceResponder: DiceResponder(), gameDelegate: sut))
        
        //when
        sut.startGame()
        let newPlayer = Player(name: "toto", diceResponder: DiceResponder(), gameDelegate: sut)
        sut.addPlayer(newPlayer)

        //then
        XCTAssertEqual(sut.players.count, 2)
    }
    
    func testPlayerLosesWhenScoreIsGreaterThan36() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: DiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        
        //when
        sut.score = 33
        _ = sut.players[0].rollDice()
        
        //then
        XCTAssertEqual(sut.players.count, 1)
        XCTAssertEqual(sut.players[0].name, "second Player")
    }
    
    func TestTheDiceNumberIsAddedToGameScoreWhenTheSumIsLessThan36() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        
        //when
        sut.score = 20
        _ = sut.players[1].rollDice()
        
        //then
        XCTAssertEqual(sut.score, 26)
    }
    
    func testGameStatusIsChangedToGameEndedWhenAllPlayersLost() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        
        //when
        sut.score = 33
        for player in sut.players {
            _ = player.rollDice()
        }
        
        //then
        XCTAssertEqual(sut.players.count, 0)
        XCTAssertEqual(sut.status,.endOfGame)
    }

    func testPlayerWhoRolledTheDiceWinWhenGameScoreeISEqualTo36() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        
        //when
        sut.score = 30
        _ = sut.players[1].rollDice()
        
        //then
        XCTAssertEqual(sut.winner?.name, sut.players[1].name)
    }
    
    func testGameStatusISEndOfGameWhenAPlayerWin() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        
        //when
        sut.score = 30
        _ = sut.players[1].rollDice()
        
        //then
        XCTAssertEqual(sut.status, .endOfGame)
    }
    
    func testStartAGameThatIsAlreadyFinished() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        sut.score = 30
        _ = sut.players[1].rollDice()
        
        //when
        sut.startGame()
        
        //then
        XCTAssertEqual(sut.status, .endOfGame)
    }
    
    func testAddingANewPlayerToAGameAlreadyFinished() {
        //given
        let firstPlayer = Player(name: "first Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        let secondPlayer = Player(name: "second Player", diceResponder: FakeDiceResponder(), gameDelegate: sut)
        sut.addPlayer(firstPlayer)
        sut.addPlayer(secondPlayer)
        sut.startGame()
        sut.score = 30
        _ = sut.players[1].rollDice()
        
        //when
        sut.addPlayer(Player(name: "toto", diceResponder: FakeDiceResponder(), gameDelegate: sut))
        
        //then
        XCTAssertEqual(sut.players.count, 2)
    }
    
}


