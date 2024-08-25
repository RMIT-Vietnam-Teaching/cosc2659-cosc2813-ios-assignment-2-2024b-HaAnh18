//
//  ModeGame.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
//

import SwiftUI

struct ModeGame: Codable {
    var name: String
    var bomb: [Int]
    var defuse: [Int]
    var attack: [Int]
    var seeFuture: [Int]
    var shuffle: [Int]
    var skip: [Int]
    var stealCard: [Int]
    var description: String
}
