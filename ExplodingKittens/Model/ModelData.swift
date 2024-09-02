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

// This function takes a JSON file name and a model type as input,
// and returns an array of the specified model type after decoding the JSON data.
func decodeJsonFromJsonFile<T: Decodable>(jsonFileName: String, model: T.Type) -> [T] {
    
    // Attempt to locate the JSON file in the app bundle.
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        // Try to load the contents of the file as Data.
        if let data = try? Data(contentsOf: file) {
            do {
                // Create a JSONDecoder instance to decode the JSON data.
                let decoder = JSONDecoder()
                
                // Decode the data into an array of the specified model type.
                let decoded = try decoder.decode([T].self, from: data)
                
                // Return the decoded array.
                return decoded
            } catch let error {
                // If decoding fails, print the error and terminate the app.
                print("Failed to decode JSON: \(error)")
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        // If the file cannot be found, print an error message and terminate the app.
        print("Couldn't load \(jsonFileName) file")
        fatalError("Couldn't load \(jsonFileName) file")
    }
    
    // Return an empty array as a fallback, though this line is typically unreachable due to fatalError above.
    return [ ] as [T]
}

var cards: [Card] = decodeJsonFromJsonFile(jsonFileName: "cards.json", model: Card.self)
var modeGame: [ModeGame] = decodeJsonFromJsonFile(jsonFileName: "modeGame.json", model: ModeGame.self)
var cardsV2: [Card] = decodeJsonFromJsonFile(jsonFileName: "cards-v2.json", model: Card.self)
