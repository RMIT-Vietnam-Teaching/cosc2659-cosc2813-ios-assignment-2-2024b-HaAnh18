//
//  ModeGame.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
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
