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
    
//    @State private var bomb: Card?
    
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
                            if playTurn {
                                withAnimation(.spring()) {
                                    getRandomCard(card: card, to: &playerCards, from: &cardGame)
                                    audioManager.playSoundEffect(sound: "pick-card", type: "mp3")

                                    
                                    if card.name == "Bomb" {
                                        addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                        
                                        if let defuseCard = playerList[0].cards.first(where: { $0.name == "Defuse" }) {

                                                withAnimation {
                                                    addCard(card: defuseCard, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                                    bomb = card

                                            }

                                        } else {
                                            updatePlayerResult(name: playerList[0].name, didWin: false, score: playerList[0].score)
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
                .font(Font.custom("Quicksand-Regular", size: 16))
            
        }
        .onAppear {
            if currentTurn == 0 {
                showYourTurn()
            }
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
            if oldCount != newCount && bomb == nil {
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

}

#Preview {
//    PickCardList(cardGame: .constant(cards), playTurn: .constant(true), playerCards: .constant(cards))
//        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//    PickCardList(cardGame: cards, playTurn: true, playerCards: cards, currentTurn: .constant(), playerList: <#T##[Player]#>, droppedCards: <#T##[Card]#>, stealCard: <#T##Bool#>, showTurn: <#T##Bool#>, isGameDataAvailable: <#T##Bool#>, numberOfPlayers: <#T##Int#>, aiTurn: <#T##() -> Void#>, screenSize: <#T##ScreenSizeCategory#>)
//    GameView(numberOfPlayers: 3)
//    Test(numberOfPlayers: 2)
    MenuView()

}
