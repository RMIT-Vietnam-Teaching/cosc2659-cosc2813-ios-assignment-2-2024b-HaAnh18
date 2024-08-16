//
//  Player.swift
//  ExplodingKittens
//
//  Created by Nana on 13/8/24.
//

import SwiftUI

struct Player: Equatable, Codable {
    var name: String
    var cards: [Card] = []
    var numberOfTurn: Int = 1
    var index: Int
}

