//
//  Card.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
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

struct Card: Codable, Equatable  {
    var id: UUID?
    var name: String
    var frontImageName: String
    var frontImage: Image {
        Image(frontImageName)
    }
    var backImageName: String
    var backImage: Image {
        Image(backImageName)
    }
//    var descri[t]
    var description: String
    var score: Int
//    var offset: CGSize = .zero
//    var startPosition: CGSize = .zero
    
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
    mutating func assignUniqueID() {
            self.id = UUID()
        }
    
    // Implementing Hashable manually
       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(name)
           hasher.combine(frontImageName)
           hasher.combine(backImageName)
           hasher.combine(description)
           hasher.combine(score)
       }
}

extension Card: Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.frontImageName == rhs.frontImageName &&
               lhs.backImageName == rhs.backImageName &&
               lhs.description == rhs.description &&
               lhs.score == rhs.score
    }
}

extension Card: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Card.self, contentType: .json)
    }
}
