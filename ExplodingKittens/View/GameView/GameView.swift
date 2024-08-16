//
//  GameView.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

//struct GameView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    GameView()
//}

//
//  DragCard.swift
//  ExplodingKitten
//
//  Created by Nana on 10/8/24.
//

import Foundation
import SwiftUI

struct GameView: View {
    @State private var draggedCard: Card?
    @State private var cardGame: [Card] = []
    @State private var droppedCards: [Card] = []
    @State private var currentCard: Card? = nil
    @State private var playTurn: Bool = true
    @State private var isRotated: Bool = true // Control variable for rotation
    @State private var playerList: [Player] = []
    @State private var currentTurn: Int = 0
    @State private var stealCard: Bool = false
    @State private var seeFuture: Bool = false
    @State private var stealPlayerIndex: Int?
    @State private var showStealOption: Bool = false
    
    var numberOfPlayers: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("game-view-bg")
                .ignoresSafeArea()
            
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("Leave Game")
                        .modifier(buttonCapsule())
                        .padding(.vertical, 20)
                })
                Spacer()
            }
            
            GeometryReader {
                let size = $0.size
                VStack(spacing: 10) {
                    if !playerList.isEmpty {
                        HStack {
                            Text("player 1: \(playerList[1].cards.count)")
                            Text("player 2: \(playerList[2].cards.count)")
                            Text("me: \(playerList[0].cards.count)")
                            Text("\(stealCard)")
                        }
                        CardList(cards: numberOfPlayers == 2 ? playerList[1].cards : playerList[2].cards, position: "top")
                            .frame(height: size.height / 3 - 20)
                    }
                    
                    HStack {
                        if numberOfPlayers > 3 && !playerList.isEmpty {
                            CardList(cards: playerList[3].cards, position: "left")
                        } else {
                            Spacer()
                        }
                        
                        Spacer()
                        VStack {
                            Text("\(currentTurn)")
                            Text("\(playTurn)")
                        }
                        
                        HStack {
                            if !playerList.isEmpty {
                                PickCardList(cardGame: $cardGame, playTurn: $playTurn, playerCards: $playerList[0].cards, currentTurn: $currentTurn, playerList: $playerList, numberOfPlayers: numberOfPlayers, aiTurn: aiTurn)
                            
                                DropDestination(droppedCards: $droppedCards, playTurn: $playTurn, draggedCard: $draggedCard, playerCards: $playerList[0].cards, currentCard: $currentCard)
                            }
                        }
                        
                        Spacer()
                        if numberOfPlayers > 2 && !playerList.isEmpty {
                            CardList(cards: playerList[1].cards, position: "right")
                        } else {
                            Spacer()
                        }
                    }
                    .frame(height: size.height / 3 + 20)
                    .padding(0)
                    .zIndex(1)
                    
                    if !playerList.isEmpty {
                        HStack{
                            DragCardList(playerCards: $playerList[0].cards, draggedCard: $draggedCard, stealCard: $stealCard, playerList: $playerList, currentTurn: $currentTurn)
                        }
                            .zIndex(1)
                            .frame(height: size.height / 3 + 40)
                    }
                }
            }
            
            if seeFuture && !cardGame.isEmpty {
                SeeFutureDialog(seeFuture: $seeFuture, cards: cardGame)
            }
        }
        .rotationEffect(.degrees(isRotated ? 0 : 180))
        .animation(.easeInOut(duration: 0.5), value: isRotated)
        .onAppear {
            getCardsForGame(to: &cardGame, numberOfPlayers: numberOfPlayers, level: "Easy")
            setUpPlayers()
            
            withAnimation {
                isRotated = true // Start rotation animation
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                AppDelegate.orientationLock = .landscapeRight
            }
            //            withAnimation {
            //                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            //                AppDelegate.orientationLock = .landscapeRight
            //            }
            
        }
        .onDisappear {
            withAnimation{
                isRotated = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                AppDelegate.orientationLock = .all
                
            }
            //            withAnimation {
            //                AppDelegate.orientationLock = .all
            //            }
        }
    }
    
    func setUpPlayers() {
        playerList = [Player(name: "player", cards: [], index: 0)]
        getCardForPlayer(to: &playerList[0].cards, from: &cardGame)
        for i in 1..<numberOfPlayers {
            playerList.append(Player(name: "aiPlayer\(i)", cards: [], index: i))
            getCardForPlayer(to: &playerList[i].cards, from: &cardGame)
        }
    }
    
    func aiTurn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if currentTurn != 0 {
                if stealCard {
                    // Wait until stealCard is false before proceeding
                    waitForStealCard {
                        self.performAiTurnActions()
                    }
                } else {
                    self.performAiTurnActions()
                }
            }
        }
    }
    
    private func waitForStealCard(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if stealCard {
                // Recursively wait until stealCard becomes false
                self.waitForStealCard(completion: completion)
            } else {
                // Once stealCard is false, continue the AI turn
                completion()
            }
        }
    }
    
    
    func performAiTurnActions() {
        withAnimation(.spring()) {
                let playCard = playRandomCard(from: &playerList[currentTurn].cards, to: &droppedCards)
                
                if let playCard = playCard {
                    checkCard(card: playCard, currentTurn: currentTurn, players: &playerList)
                }

                for _ in 0..<playerList[currentTurn].numberOfTurn {
                    if !cardGame.isEmpty {
                        getRandomCard(card: cardGame[cardGame.count - 1], to: &playerList[currentTurn].cards, from: &cardGame)
                    }
                }
                
                playerList[currentTurn].numberOfTurn = 1
            }
            currentTurn = (currentTurn + 1) % numberOfPlayers
    }
    
    func checkCard(card: Card, currentTurn: Int, players: inout [Player]) {
        switch card.name {
        case "Skip": 
            players[currentTurn].numberOfTurn = players[currentTurn].numberOfTurn - 1
            break
            
        case "Attack":
            players[currentTurn].numberOfTurn -= 1
            players[(currentTurn + 1) % numberOfPlayers].numberOfTurn += 1
            break
        case "See The Future":
            break
        case "Steal A Card":
            let options = players.filter { $0.index != currentTurn }
            stealPlayerIndex = options[Int.random(in: 0..<options.count)].index

            if players[stealPlayerIndex!].name == players[0].name {
                stealCard = true
            } else {
                var currentPlayerCards = players[currentTurn].cards
                var stealingPlayerCards = players[stealPlayerIndex!].cards
                aiGiveCard(to: &currentPlayerCards, from: &stealingPlayerCards)
                players[currentTurn].cards = currentPlayerCards
                players[stealPlayerIndex!].cards = stealingPlayerCards
            }
            break
        default:
            break
        }
    }
    
    
    
}

#Preview {
    GameView(numberOfPlayers: 3)
}




