//
//  ModelData.swift
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

func decodeJsonFromJsonFile<T: Decodable>(jsonFileName: String, model: T.Type) -> [T] {
    
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([T].self, from: data)
                return decoded
            } catch let error {
                print("Failed to decode JSON: \(error)")
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else  {
        print("Couldn't load \(jsonFileName) file")
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [T]
}


var cards: [Card] = decodeJsonFromJsonFile(jsonFileName: "cards.json", model: Card.self)
var modeGame: [ModeGame] = decodeJsonFromJsonFile(jsonFileName: "modeGame.json", model: ModeGame.self)
var cardsV2: [Card] = decodeJsonFromJsonFile(jsonFileName: "cards-v2.json", model: Card.self)
