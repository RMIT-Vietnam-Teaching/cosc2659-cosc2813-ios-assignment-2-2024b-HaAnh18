//
//  PickCardList.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct PickCardList: View {
    @EnvironmentObject var audioManager: AudioManager

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
    @Binding var isGameDataAvailable: Bool?
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
                                    audioManager.playSoundEffect(sound: "pick-card", type: "mp3")

                                    
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
                                            updatePlayerResult(name: playerList[0].name, didWin: false)
                                            removeGameDataFromUserDefaults()
                                            withAnimation {
                                                winGame = false
                                                stealCard = false
                                                isGameDataAvailable = false
                                                audioManager.playSoundEffect(sound: "gameover", type: "mp3")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    
                }
            }
            
            Text("\(cardGame.count) cards left")
                .font(Font.custom("Quicksand-Regular", size: 20))
            
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
//        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//    PickCardList(cardGame: cards, playTurn: true, playerCards: cards, currentTurn: .constant(), playerList: <#T##[Player]#>, droppedCards: <#T##[Card]#>, stealCard: <#T##Bool#>, showTurn: <#T##Bool#>, isGameDataAvailable: <#T##Bool#>, numberOfPlayers: <#T##Int#>, aiTurn: <#T##() -> Void#>, screenSize: <#T##ScreenSizeCategory#>)
//    GameView(numberOfPlayers: 3)
//    Test(numberOfPlayers: 2)
    MenuView()

}
