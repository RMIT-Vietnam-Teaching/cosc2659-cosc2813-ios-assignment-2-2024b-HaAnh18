//
//  Card.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
//

import Foundation
import SwiftUI

struct Card: Codable, Equatable, Hashable  {
    
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
}

extension Card: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Card.self, contentType: .json)
    }
}
