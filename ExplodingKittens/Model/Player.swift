//
//  Player.swift
//  ExplodingKittens
//
//  Created by Nana on 13/8/24.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Nguyen Tran Ha Anh
  ID: s3938490
  Created  date: 06/08/2024
  Last modified: 03/09/2024
  Acknowledgement:
*/

import SwiftUI

struct Player: Equatable, Codable, Hashable {
    var name: String
    var cards: [Card] = []
    var numberOfTurn: Int = 1
    var index: Int
    var countinuePlay: Bool
    var win: Int = 0
    var lose: Int = 0
    var level: Int = 1
    var score: Int = 0
    
    // Computed property to calculate the win rate
    var winRate: Double {
        let totalGames = win + lose
        return totalGames > 0 ? (Double(win) / Double(totalGames)) * 100 : 0.0
    }
    
    var archivement: [String: [String]] {
        var arr: [String: [String]] = [:]
        if win >= 5 {
            arr["Win 5 Games"] = ["lightblue", "star.circle"]
        }
        
        if score >= 50 {
            arr["Get 50 points"] = ["red", "heart.circle"]
        }
        
        if winRate == 100 {
            arr["Perfect Wins"] = ["game-view-bg", "moon.stars.circle.fill"]
        }
        
        return arr
    }
    
    mutating func updateLevel() {
        // Level up for every 3 wins
        level = 1 + (win / 3)
    }
}

func getPlayers() -> [Player] {
    if let savedPlayersData = UserDefaults.standard.data(forKey: "players") {
        if let decodedPlayers = try? JSONDecoder().decode([Player].self, from: savedPlayersData) {
            return decodedPlayers
        }
    }
    return []
}

func savePlayers(_ players: [Player]) {
    if let encodedPlayers = try? JSONEncoder().encode(players) {
        print("Save player")
        UserDefaults.standard.set(encodedPlayers, forKey: "players")
    }
}

func updatePlayerResult(name: String, didWin: Bool, score: Int) {
    var players = getPlayers()
    
    if let index = players.firstIndex(where: { $0.name == name }) {
        if didWin {
            players[index].win += 1
            players[index].updateLevel()
        } else {
            players[index].lose += 1
        }
    } else {
        // If the player does not exist, you can add a new player
        var newPlayer = Player(name: name, index: players.count, countinuePlay: true, win: didWin ? 1 : 0, lose: didWin ? 0 : 1)
        if didWin {
            newPlayer.updateLevel() // Update level if the player wins the first game
        }
        players.append(newPlayer)
    }
    
    savePlayers(players)
}

func sortPlayers(_ players: [Player]) -> [Player] {
    return players.sorted(by: {
        if $0.level == $1.level {
            return $0.winRate > $1.winRate
        } else {
            return $0.level > $1.level
        }
    })
}

func getPlayer(name: String) -> Player? {
    let players = getPlayers() // Retrieve the list of players
    
    if let player = players.first(where: { $0.name == name }) {
        return player
    } else {
        return nil // Return nil if the player is not found
    }
}
