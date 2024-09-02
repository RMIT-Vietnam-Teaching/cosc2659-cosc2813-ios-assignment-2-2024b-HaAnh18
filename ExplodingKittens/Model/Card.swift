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
    var description: String
    var score: Int
  
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

// This extension makes the Card struct conform to the Hashable protocol,
// allowing it to be used in collections that require hashing, like Sets or as keys in Dictionaries.
extension Card: Hashable {
    // This is the equality operator for the Card struct, required by the Hashable protocol.
    // It checks if two Card instances are equal by comparing all their properties.
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.frontImageName == rhs.frontImageName &&
               lhs.backImageName == rhs.backImageName &&
               lhs.description == rhs.description &&
               lhs.score == rhs.score
        // The two Card instances are considered equal if all their properties are equal.
    }
}

// This extension makes the Card struct conform to the Transferable protocol,
// allowing instances of Card to be shared or transferred between apps or devices.
extension Card: Transferable {
    // This computed property defines how the Card data should be transferred.
    // The TransferRepresentation protocol helps handle the representation of the Card for transfer purposes.
    static var transferRepresentation: some TransferRepresentation {
        // Here, the transfer representation is defined using CodableRepresentation,
        // which serializes the Card instance as JSON. This allows the Card to be transferred
        // in a standard format that can be easily deserialized on the receiving end.
        CodableRepresentation(for: Card.self, contentType: .json)
    }
}
