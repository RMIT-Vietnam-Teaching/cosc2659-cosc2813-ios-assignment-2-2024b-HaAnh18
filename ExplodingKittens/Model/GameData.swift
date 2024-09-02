//
//  Game.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
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

import Foundation
import SwiftUI

struct GameData: Codable {
    var playerName: String = ""
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
    var bombCard: Card?
    var percentBomb: CGFloat = 0
    var level: Int = 1
}

func removeGameDataFromUserDefaults() {
    UserDefaults.standard.removeObject(forKey: "gameData")
    print("Game data removed from UserDefaults.")
}

