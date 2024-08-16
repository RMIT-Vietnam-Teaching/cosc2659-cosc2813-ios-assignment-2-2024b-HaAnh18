//
//  PlayFunction.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

//func randomPlay(cards: ) -> <#return type#> {
//    <#function body#>
//}

func addCardFromList(cards: [Card], count: Int, to destination: inout [Card], remove: Bool, from cardList: inout [Card]) {
    for _ in 0..<count {
        if let card = cards.randomElement() {
            destination.append(card)
            if remove {
                removeCard(card: card, from: &cardList)
            }
        }
    }
}

func addCard(card: Card, count: Int, to destination: inout [Card], remove: Bool, from cardList: inout [Card]) {
    for _ in 0..<count {
        destination.append(card)
        if remove == true {
            removeCard(card: card, from: &cardList)
        }
    }
}

func removeCard(card: Card, from cards: inout [Card]) {
    if let index = cards.firstIndex(of: card) {
        cards.remove(at: index)
    }
}

func getRandomCard(card: Card, to destination: inout [Card], from removeList: inout [Card]) {
    addCard(card: card, count: 1, to: &destination, remove: true, from: &removeList)
}

func getCardsForGame(to destination: inout [Card], numberOfPlayers: Int, level: String) {
    let cardsForEasyGame: [Int: [String: Int]] = [
        2: ["Bomb": 1, "Defuse": 3, "Attack": 3, "See The Future": 4, "Shuffle": 4, "Skip": 4, "Steal A Card": 4],
        3: ["Bomb": 2, "Defuse": 4, "Attack": 4, "See The Future": 4, "Shuffle": 5, "Skip": 5, "Steal A Card": 5],
        4: ["Bomb": 3, "Defuse": 5, "Attack": 5, "See The Future": 5, "Shuffle": 6, "Skip": 6, "Steal A Card": 6]
    ]
    
    var emptyCardList: [Card] = []
    if let counts = cardsForEasyGame[numberOfPlayers] {
        for (cardName, count) in counts {
            addCardFromList(cards: cards.filter { $0.name == cardName }, count: count, to: &destination, remove: false, from: &emptyCardList)
        }
    }

    destination.shuffle()
}

func getCardForPlayer(to destination: inout [Card], from removeList: inout [Card]) {
    addCardFromList(cards: removeList.filter { $0.name == "Defuse" }, count: 1, to: &destination, remove: true, from: &removeList)
    addCardFromList(cards: removeList.filter { $0.name != "Bomb" && $0.name != "Defuse" }, count: 4, to: &destination, remove: true, from: &removeList)
}

func playRandomCard(from removeList: inout [Card], to destination: inout [Card]) -> Card? {
    let playOrNot: Int = Int.random(in: 0...1)
    if playOrNot == 0 {
        return nil
    }
    let listNotDefuse = removeList.filter { $0.name != "Defuse" }
    let playCard = listNotDefuse[Int.random(in: 0...listNotDefuse.count - 1)]

//    let playCard = removeList[Int.random(in: 0...removeList.count - 1)]
    addCard(card: playCard, count: 1, to: &destination, remove: true, from: &removeList)
    return playCard
}

func aiGiveCard(to destination: inout [Card], from removeList: inout [Card]) {
    let cardNames = ["See The Future", "Steal A Card", "Skip", "Attack", "Defuse"]
    
    
    if let cardName = cardNames.first(where: { name in removeList.contains(where: { $0.name.contains(name) }) }),
       let card = removeList.first(where: { $0.name == cardName }) {
        addCard(card: card, count: 1, to: &destination, remove: true, from: &removeList)
        removeCard(card: card, from: &removeList)
        print("List: \(destination.count)")
        print("removeList: \(removeList.count)")
    }
}
