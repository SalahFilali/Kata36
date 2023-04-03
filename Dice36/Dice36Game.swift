//
//  Dice36Game.swift
//  Dice36
//
//  Created by Salah Filali on 26/1/2023.
//

import Foundation


public class Dice36Game {
    
    var score: Int = 0
    private(set) var players: [Player] = []
    private(set) var status: GameStatus = .gatheringPlayers
    private(set) var winner: Player? = nil
    
    public func addPlayer(_ player: Player) {
        if status == .gatheringPlayers {
            players.append(player)
            status = .gatheringPlayers
        }
    }
    
    public func startGame() {
        if status == .gatheringPlayers {
            status = .gameStarted
        }
    }
    
    private func kickPlayerFromGame(_ player: Player) {
        self.players.removeAll{ $0.name == player.name }
    }
    
    private func updateGameStatusAfterKickingPlayer() {
        if self.players.count == 0 {
            self.status = .endOfGame
        }
    }
    
}

extension Dice36Game: GameDelegate {
    
    public func addDiceResultToScore(_ score: Int, from player: Player) {
        let newScore = self.score+score
        
        if newScore < 36 {
            self.score = newScore
        }
        if newScore > 36 {
            self.kickPlayerFromGame(player)
            self.updateGameStatusAfterKickingPlayer()
        }
        
        if newScore == 36 {
            self.winner = player
            self.status = .endOfGame
        }
    }
    
    
    
}

public protocol GameDelegate {
    func addDiceResultToScore(_ score: Int, from player: Player)
}
