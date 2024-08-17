//
//  Card.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
//

import Foundation
import SwiftUI

struct Card: Codable, Equatable, Hashable  {
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
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
    mutating func assignUniqueID() {
            self.id = UUID()
        }
}

extension Card: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Card.self, contentType: .json)
    }
}
