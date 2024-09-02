//
//  PlayFunction.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
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

// Function to add cards from one list to another with optional removal from the source list.
func addCardFromList(cards: [Card], count: Int, to destination: inout [Card], remove: Bool, from cardList: inout [Card]) {
    
    // Loop to add the specified number of cards.
    for _ in 0..<count {
        
        // Randomly select a card from the provided list.
        if let card = cards.randomElement() {
            // Append the selected card to the destination list.
            destination.append(card)
            
            // If 'remove' is true, remove the card from the original card list.
            if remove {
                removeCard(card: card, from: &cardList)
            }
            
            // Assign a unique ID to the last card added to the destination list.
            destination[destination.count - 1].assignUniqueID()
        }
    }
}

// Function to add a specified number of copies of a card to a destination list, with an option to remove it from the source list.
func addCard(card: Card, count: Int, to destination: inout [Card], remove: Bool, from cardList: inout [Card]) {
    // Loop to add the specified number of copies of the card.
    for _ in 0..<count {
        // Append the card to the destination list.
        destination.append(card)
        
        // If the remove flag is true, remove the card from the original card list.
        if remove == true {
            removeCard(card: card, from: &cardList)
        }
    }
}

// Function to remove a specific card from a list of cards.
func removeCard(card: Card, from cards: inout [Card]) {
    // Check if the card exists in the list and get its index.
    if let index = cards.firstIndex(of: card) {
        // Remove the card from the list at the found index.
        cards.remove(at: index)
    }
}

// Function to move a single card from one list to another, removing it from the source.
func getRandomCard(card: Card, to destination: inout [Card], from removeList: inout [Card]) {
    // Add the card to the destination list and remove it from the source list.
    addCard(card: card, count: 1, to: &destination, remove: true, from: &removeList)
}

// Function to set up the cards for a game, adding them to the destination list based on the number of players, mode, and level.
func getCardsForGame(to destination: inout [Card], numberOfPlayers: Int, mode: String, cardList: [Card], level: Int) {
    // Define a variable to hold the card distribution rules based on the mode.
    var cardGame:  [Int: [String: Int]]
    
    // Define the card distributions for an "Easy" game.
    let cardsForEasyGame: [Int: [String: Int]] = [
        2: ["Bomb": 1, "Defuse": 3, "See The Future": 3 + level, "Shuffle": 3 + level, "Skip": 3 + level],
        3: ["Bomb": 2, "Defuse": 4, "See The Future": 3 + level, "Shuffle": 4 + level, "Skip": 4 + level],
        4: ["Bomb": 3, "Defuse": 5, "See The Future": 4 + level, "Shuffle": 5 + level, "Skip": 5 + level]
    ]
    
    // Define the card distributions for a "Medium" game.
    let cardsForMediumGame: [Int: [String: Int]] = [
        2: ["Bomb": 1, "Defuse": 3, "See The Future": 3 + level, "Shuffle": 3 + level, "Skip": 3 + level, "Steal A Card": 3 + level],
        3: ["Bomb": 2, "Defuse": 4, "See The Future": 3 + level, "Shuffle": 4 + level, "Skip": 4 + level, "Steal A Card": 4 + level],
        4: ["Bomb": 3, "Defuse": 5, "See The Future": 4 + level, "Shuffle": 5 + level, "Skip": 5 + level, "Steal A Card": 5 + level]
    ]
    
    // Define the card distributions for a "Hard" game.
    let cardsForHardGame: [Int: [String: Int]] = [
        2: ["Bomb": 1, "Defuse": 3, "Attack": 2 + level, "See The Future": 3 + level, "Shuffle": 3 + level, "Skip": 3 + level, "Steal A Card": 3 + level],
        3: ["Bomb": 2, "Defuse": 4, "Attack": 3 + level, "See The Future": 3 + level, "Shuffle": 4 + level, "Skip": 4 + level, "Steal A Card": 4 + level],
        4: ["Bomb": 3, "Defuse": 5, "Attack": 4 + level, "See The Future": 4 + level, "Shuffle": 5 + level, "Skip": 5 + level, "Steal A Card": 5 + level]
    ]
    
    // Assign the appropriate card distribution based on the selected game mode.
    if mode == "Easy" {
        cardGame = cardsForEasyGame
    } else if mode == "Medium" {
        cardGame = cardsForMediumGame
    } else {
        cardGame = cardsForHardGame
    }
    
    // Create an empty list to use as a placeholder for removing cards.
    var emptyCardList: [Card] = []
    
    // Get the card counts for the specified number of players from the selected game mode.
    if let counts = cardGame[numberOfPlayers] {
        // Iterate over the card types and their counts.
        for (cardName, count) in counts {
            // Filter the available cards by name and add the specified count to the destination list.
            addCardFromList(cards: cardList.filter { $0.name == cardName }, count: count, to: &destination, remove: false, from: &emptyCardList)
        }
    }

    // Shuffle the destination list to randomize the card order.
    destination.shuffle()
}

// Function to distribute specific cards to a player's hand from a removeList.
func getCardForPlayer(to destination: inout [Card], from removeList: inout [Card]) {
    // Add one "Defuse" card to the destination list (player's hand) and remove it from the removeList.
    addCardFromList(cards: removeList.filter { $0.name == "Defuse" }, count: 1, to: &destination, remove: true, from: &removeList)
    
    // Add four cards (excluding "Bomb" and "Defuse") to the destination list and remove them from the removeList.
    addCardFromList(cards: removeList.filter { $0.name != "Bomb" && $0.name != "Defuse" }, count: 4, to: &destination, remove: true, from: &removeList)
}

// Function to randomly play a card from the removeList and move it to the destination list.
func playRandomCard(from removeList: inout [Card], to destination: inout [Card]) -> Card? {
    // Randomly decide whether to play a card or not (0 means don't play, 1 means play).
    let playOrNot: Int = Int.random(in: 0...1)
    
    // If the decision is not to play, return nil.
    if playOrNot == 0 {
        return nil
    }
    
    // Filter the removeList to exclude cards with the name "Defuse".
    let listNotDefuse = removeList.filter { $0.name != "Defuse" }
    
    // Select a random card from the filtered list (excluding "Defuse").
    let playCard = listNotDefuse[Int.random(in: 0...listNotDefuse.count - 1)]

    // Add the selected card to the destination list and remove it from the removeList.
    addCard(card: playCard, count: 1, to: &destination, remove: true, from: &removeList)
    
    // Return the card that was played.
    return playCard
}

// Function for AI to give a card from the removeList to the destination list based on a prioritized list of card names.
func aiGiveCard(to destination: inout [Card], from removeList: inout [Card]) {
    // Define the prioritized list of card names the AI should consider giving.
    let cardNames = ["Shuffle", "See The Future", "Steal A Card", "Skip", "Attack", "Defuse"]
    
    // Find the first card name from the prioritized list that exists in the removeList.
    if let cardName = cardNames.first(where: { name in removeList.contains(where: { $0.name.contains(name) }) }),
       
       // Find the first card in the removeList that matches the selected card name.
       let card = removeList.first(where: { $0.name == cardName }) {
        
        // Add the found card to the destination list and remove it from the removeList.
        addCard(card: card, count: 1, to: &destination, remove: true, from: &removeList)
    }
}

// Function to wait until the stealCard flag becomes false, then continue the AI's turn.
func waitForStealCard(stealCard: Bool, completion: @escaping () -> Void) {
    // Schedule the following code to run after a 0.5-second delay.
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        if stealCard {
            // If stealCard is still true, recursively call the function to wait again.
            waitForStealCard(stealCard: stealCard, completion: completion)
        } else {
            // Once stealCard is false, continue the AI turn
            completion()
        }
    }
}

// Function to check the effects of a played card and update the game state accordingly.
func checkCard(card: Card, currentTurn: Int, players: inout [Player], cardGame: inout [Card], numberOfPlayers: Int, completion: @escaping (Bool) -> Void) {
    switch card.name {
        
    // Case for the "Skip" card: Decreases the current player's turn count by 1.
    case "Skip":
        players[currentTurn].numberOfTurn = players[currentTurn].numberOfTurn - 1
        players[currentTurn].score += card.score
        completion(false)
        break
        
    // Case for the "Attack" card: Decreases the current player's turn count by 1,
    // and adds an extra turn to the next player in the sequence.
    case "Attack":
        players[currentTurn].numberOfTurn -= 1
        players[(currentTurn + 1) % numberOfPlayers].numberOfTurn += 1
        players[currentTurn].score += card.score
        completion(false)
        break

    // Case for the "See The Future" card: Increases the current player's score by the card's score.
    case "See The Future":
        players[currentTurn].score += card.score
        completion(false)
        break
       
    // Case for the "Steal A Card" card: Allows the current player to steal a card from another player.
    case "Steal A Card":
        players[currentTurn].score += card.score
        
        // Filter out the current player to find potential targets for stealing a card.
        let options = players.filter { $0.index != currentTurn }
        let stealPlayerIndex = options[Int.random(in: 0..<options.count)].index

        // Check if the player to steal from is the first player.
        if players[stealPlayerIndex].name == players[0].name {
            // If the player is the first player, delay the completion for 2 seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(true) // Steal card was successful after delay
            }
        } else {
            // If stealing from another player, perform the steal action immediately.
            var currentPlayerCards = players[currentTurn].cards
            var stealingPlayerCards = players[stealPlayerIndex].cards
            aiGiveCard(to: &currentPlayerCards, from: &stealingPlayerCards)
            players[currentTurn].cards = currentPlayerCards
            players[stealPlayerIndex].cards = stealingPlayerCards
            completion(false) // Steal card action does not need a delay
        }
        break
      
    // Case for the "Shuffle" card: Shuffles the deck and increases the current player's score.
    case "Shuffle":
        players[currentTurn].score += card.score
        cardGame.shuffle()
        completion(false)
        break
      
    // Default case for any unrecognized card names.
    default:
        completion(false)
        break
    }
}

// Function to calculate the percentage of "Bomb" cards in a list of cards.
func calculateBombPercent(cards: [Card]) -> CGFloat {
    // Count the number of cards whose name contains "Bomb".
    let bombCount = cards.filter { $0.name.contains("Bomb") }.count
    
    // Get the total number of cards in the list.
    let totalCount = cards.count
    
    // Ensure there is no division by zero.
    guard totalCount > 0 else { return 0 }
    
    // Calculate and return the percentage of "Bomb" cards as a CGFloat.
    return (CGFloat(bombCount) / CGFloat(totalCount)) * 100
}
