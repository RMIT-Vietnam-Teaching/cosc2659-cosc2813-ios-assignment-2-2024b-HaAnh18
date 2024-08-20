//
//  PickCardList.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct PickCardList: View {
    @State private var cardSize: CGFloat? = nil
    @Binding var cardGame: [Card]
    @Binding var playTurn: Bool
    @Binding var playerCards: [Card]
    @Binding var currentTurn: Int
    @Binding var playerList: [Player]
    @Binding var droppedCards: [Card]
    @Binding var winGame: Bool?
    @Binding var stealCard: Bool
    @Binding var showTurn: Bool
    var numberOfPlayers: Int
    let aiTurn: () -> Void
    var screenSize: ScreenSizeCategory

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(cardGame, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: cardSize, height: cardSize)
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
                                            stealCard = false

                                        }
                                        
                                    }
                                }
                            }
                        }
                    
                }
            }
            
            Text("\(cardGame.count) cards left")
            
        }
        .onAppear {
            setComponentSize()
            showYourTurn()
        }
        .onChange(of: currentTurn, initial: true, { previousPlayer, currentPlayer in
            if previousPlayer != currentPlayer {
                if currentPlayer == 0 {
                    playTurn = true
                    showYourTurn()
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
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            cardSize = 150
        case .medium:
            cardSize = 180
        case .large:
            cardSize = 220
        case .extraLarge:
            cardSize = 120
        }
    }
}

#Preview {
//    PickCardList(cardGame: .constant(cards), playTurn: .constant(true), playerCards: .constant(cards))
    GameView(numberOfPlayers: 3)
//    Test(numberOfPlayers: 2)
}
