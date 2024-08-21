//
//  ModelData.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
//

import Foundation

func decodeJsonFromJsonFile<T: Decodable>(jsonFileName: String, model: T.Type) -> [T] {
    
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([T].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else  {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [T]
}

//import Foundation

//func decodeJsonFromJsonFile<T: Decodable>(jsonFileName: String, withExtension fileExtension: String = "json", model: T.Type) -> [T] {
//    guard let file = Bundle.main.url(forResource: jsonFileName, withExtension: fileExtension) else {
//        fatalError("Couldn't load \(jsonFileName).\(fileExtension) file")
//    }
//    
//    do {
//        let data = try Data(contentsOf: file)
//        let decoder = JSONDecoder()
//        let decoded = try decoder.decode([T].self, from: data)
//        return decoded
//    } catch {
//        fatalError("Failed to decode JSON: \(error)")
//    }
//}


//var personalColors: [PersonalColor] = decodeJsonFromJsonFile(jsonFileName: "personalColor.json", model: PersonalColor.self)
var cards: [Card] = decodeJsonFromJsonFile(jsonFileName: "cards.json", model: Card.self)
