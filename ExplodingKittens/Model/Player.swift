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
    // Attempt to retrieve the data stored under the key "players" from UserDefaults.
    if let savedPlayersData = UserDefaults.standard.data(forKey: "players") {
        
        // Attempt to decode the retrieved data into an array of Player objects.
        if let decodedPlayers = try? JSONDecoder().decode([Player].self, from: savedPlayersData) {
            // If decoding is successful, return the decoded array of Player objects.
            return decodedPlayers
        }
    }
    
    // If no data is found or decoding fails, return an empty array.
    return []
}

func savePlayers(_ players: [Player]) {
    // Attempt to encode the array of Player objects into Data using JSONEncoder.
    if let encodedPlayers = try? JSONEncoder().encode(players) {
        
        // If encoding is successful, print a confirmation message.
        print("Save player")
        
        // Save the encoded data to UserDefaults under the key "players".
        UserDefaults.standard.set(encodedPlayers, forKey: "players")
    }
}

func updatePlayerResult(name: String, didWin: Bool, score: Int) {
    // Retrieve the current list of players from UserDefaults.
    var players = getPlayers()
    
    // Find the index of the player with the given name in the list.
    if let index = players.firstIndex(where: { $0.name == name }) {
        if didWin {
            // Increment the player's win count by 1.
            players[index].win += 1
            
            // Add the score from this game to the player's total score.
            players[index].score += score
            
            // Update the player's level based on their win count, score, or other criteria.
            players[index].updateLevel()
        } else {
            // Increment the player's loss count by 1.
            players[index].lose += 1
        }
    } else {
        // If the player does not exist, you can add a new player
        var newPlayer = Player(name: name, index: players.count, countinuePlay: true, win: didWin ? 1 : 0, lose: didWin ? 0 : 1)
        if didWin {
            newPlayer.score = score
            newPlayer.updateLevel() // Update level if the player wins the first game
        }
        players.append(newPlayer)
    }
    savePlayers(players)
}

// This function sorts an array of Player objects based on their level and win rate.
func sortPlayers(_ players: [Player]) -> [Player] {
    // The sorted(by:) method sorts the array according to the closure provided.
    // The closure compares two Player objects, $0 and $1.
    return players.sorted(by: {
        if $0.level == $1.level {
            // Sort them by win rate in descending order (higher win rate first).
            return $0.winRate > $1.winRate
        } else {
            // Sort them by level in descending order (higher level first).
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
