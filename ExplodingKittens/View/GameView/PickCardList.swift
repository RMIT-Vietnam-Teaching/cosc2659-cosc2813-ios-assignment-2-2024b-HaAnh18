//
//  PickCardList.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct PickCardList: View {
    @Binding var cardGame: [Card]
    @Binding var playTurn: Bool
    @Binding var playerCards: [Card]
    @Binding var currentTurn: Int
    @Binding var playerList: [Player]
    @Binding var droppedCards: [Card]
    @Binding var winGame: Bool?
    var numberOfPlayers: Int
    let aiTurn: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(cardGame, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: 120, height: 120)
                        .scaledToFit()
                        .onTapGesture {
                            if playTurn {
                                withAnimation(.spring()) {
                                    getRandomCard(card: card, to: &playerCards, from: &cardGame)
                                    
                                    
                                    if card.name == "Bomb" {
                                        addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                        
                                        if let defuseCard = playerList[0].cards.first(where: { $0.name == "Defuse" }) {
                                            addCard(card: defuseCard, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                            
                                            addCard(card: card, count: 1, to: &cardGame, remove: true, from: &droppedCards)
                                            playerList[currentTurn].numberOfTurn -= 1
                                            
                                            if playerList[currentTurn].numberOfTurn == 0 {
                                                playerList[currentTurn].numberOfTurn = 1
                                                currentTurn = (currentTurn + 1) % numberOfPlayers
                                            }

                                        } else {
                                            winGame = false
                                        }
                                        
                                    }
                                }
                            }
                        }
                    
                }
            }
            
            Text("\(cardGame.count) cards left")
        }
        .onChange(of: currentTurn, initial: true, { previousPlayer, currentPlayer in
            if previousPlayer != currentPlayer {
                if currentPlayer == 0 {
                    playTurn = true
//                    playerList[currentTurn].numberOfTurn = 1
                } else {
                    playTurn = false
                    aiTurn()
                }
            }
        })
        .onChange(of: cardGame.count, initial: false, { oldCount, newCount in
            if oldCount != newCount {
                if playTurn {
                    playerList[currentTurn].numberOfTurn -= 1
                    if playerList[currentTurn].numberOfTurn == 0 {
                        playerList[currentTurn].numberOfTurn = 1
                        currentTurn = (currentTurn + 1) % numberOfPlayers
                    }
                }
            }
        })
    }
}

#Preview {
//    PickCardList(cardGame: .constant(cards), playTurn: .constant(true), playerCards: .constant(cards))
    GameView(numberOfPlayers: 3)
//    Test(numberOfPlayers: 2)
}
