//
//  PickCardList.swift
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

struct PickCardList: View {
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var cardGame: [Card]
    @Binding var playTurn: Bool
    @Binding var playerCards: [Card]
    @Binding var currentTurn: Int
    @Binding var playerList: [Player]
    @Binding var droppedCards: [Card]
    @Binding var winGame: Bool?
    @Binding var stealCard: Bool
    @Binding var showTurn: Bool
    @Binding var isGameDataAvailable: Bool?
    @Binding var bomb: Card?
        
    var numberOfPlayers: Int
    let aiTurn: () -> Void
    var screenSize: ScreenSizeCategory

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(cardGame, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220, height: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220)
                        .scaledToFit()
                        .onTapGesture {
                            // Check if it's the player's turn.
                            if playTurn {
                                withAnimation(.spring()) {
                                    
                                    // Pick a random card from the card game deck and add it to the player's hand.
                                    getRandomCard(card: card, to: &playerCards, from: &cardGame)
                                    
                                    // Play a sound effect for picking a card.
                                    audioManager.playSoundEffect(sound: "pick-card", type: "mp3")
                                    
                                    if card.name == "Bomb" {
                                        // Move the "Bomb" card to the dropped cards pile.
                                        addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                        
                                        // Check if the player has a "Defuse" card to neutralize the "Bomb".
                                        if let defuseCard = playerList[0].cards.first(where: { $0.name == "Defuse" }) {
                                                withAnimation {
                                                    // Use the "Defuse" card to neutralize the "Bomb" and remove it from the player's hand.
                                                    addCard(card: defuseCard, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                                    bomb = card
                                            }

                                        } else {
                                            // Update the player's result, marking them as having lost the game.
                                            updatePlayerResult(name: playerList[0].name, didWin: false, score: playerList[0].score)
                                            
                                            // Remove any saved game data since the game is now over.
                                            removeGameDataFromUserDefaults()
                                            withAnimation {
                                                // Set the game as lost.
                                                winGame = false
                                                stealCard = false
                                                
                                                // Indicate that no game data is available for resumption.
                                                isGameDataAvailable = false
                                                
                                                // Play a "game over" sound effect.
                                                audioManager.playSoundEffect(sound: "gameover", type: "mp3")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                }
            }
            
            Text("\(cardGame.count) cards left", manager: localizationManager)
                .font(Font.custom("Quicksand-Regular", size: 16))
        }
        .onAppear {
            if currentTurn == 0 {
                showYourTurn()
            }
        }
        .onChange(of: currentTurn, initial: true, { previousPlayer, currentPlayer in
            // Check if the turn has actually changed
            if previousPlayer != currentPlayer {
                // If the current player is the human player
                if currentPlayer == 0 {
                    // Enable the player's turn by setting `playTurn` to true.
                    playTurn = true
                    showYourTurn()
                } else {
                    // Disable the player's turn by setting `playTurn` to false.
                    playTurn = false
                    
                    // Trigger the AI's turn
                    aiTurn()
                }
            }
        })
        .onChange(of: cardGame.count, initial: false, { oldCount, newCount in
            // Check if the number of cards in `cardGame` has actually changed and there is no active bomb
            if oldCount != newCount && bomb == nil {
                if playTurn {
                    // Decrement the number of turns remaining for the current player.
                    playerList[currentTurn].numberOfTurn -= 1
                    
                    if playerList[currentTurn].numberOfTurn == 0 {
                        // Reset the number of turns for the current player to 1 for the next round.
                        playerList[currentTurn].numberOfTurn = 1
                        
                        // Move to the next player's turn.
                        currentTurn = (currentTurn + 1) % numberOfPlayers
                    }
                }
            }
        })
    }
    
    func showYourTurn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showTurn = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showTurn = false
            }
        }
    }

}

#Preview {
    MenuView()
}
