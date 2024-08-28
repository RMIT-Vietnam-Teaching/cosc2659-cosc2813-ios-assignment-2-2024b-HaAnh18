//
//  Game.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//

import Foundation
import SwiftUI

struct GameData: Codable {
    var playerList: [Player] = []
    var cardGame: [Card] = []
    var droppedCards: [Card] = []
    var playTurn: Bool = true
    var currentTurn: Int = 0
    var stealCard: Bool = false
    var seeFuture: Bool = false
    var stealOther: Bool = false
    var showTurn: Bool = true
    var showInput: Bool = true
    var numberOfPlayers: Int = 2
    var cardOffsets: [CGSize] = []
    var modeGame: String = "Easy"
}

func loadGameData() -> GameData? {
    if let savedData = UserDefaults.standard.data(forKey: "gameData"),
       let decodedData = try? JSONDecoder().decode(GameData.self, from: savedData) {
        print("Game data loaded")
        return decodedData
    }
    return nil
}

func removeGameDataFromUserDefaults() {
    UserDefaults.standard.removeObject(forKey: "gameData")
    print("Game data removed from UserDefaults.")
}

