//
//  GameView.swift
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

struct GameView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var localizationManager: LocalizationManager
    @EnvironmentObject var audioManager: AudioManager

    @State private var cardGame: [Card] = []
    @State private var droppedCards: [Card] = []
    @State private var playTurn: Bool = true
    @State private var playerList: [Player] = []
    @State private var currentTurn: Int = 0
    @State private var stealCard: Bool = false
    @State private var seeFuture: Bool = false
    @State private var stealOther: Bool = false
    @State private var showTurn: Bool = true
    @State private var showInput: Bool = true
    @State private var numberOfPlayers: Int = 2
    @State private var winGame: Bool?
    @State private var playerName: String = ""
    @State private var showingSheet: Bool = false
    @State private var currentScore: Int = 0

    @State private var cardOffsets: [CGSize] = []
    @Binding var isGameDataAvailable: Bool?
    @Binding var modeGame: String
    @Binding var theme: String
    
    var resumeGame: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let sizeCategory = getScreenSizeCategory(for: geometry.size)
            
            ZStack(alignment: .top) {
                Color("game-view-bg")
                    .ignoresSafeArea()
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()

                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("custom-black"))

                        Text("Menu", manager: localizationManager)
                            .font(Font.custom("Quicksand-Regular", size: 24))
                            .foregroundColor(Color("custom-black"))
                    })
                    
                    Spacer()
                    
                    if !playerList.isEmpty && playerList[currentTurn].countinuePlay {
                        VStack {
                            HStack {
                                Text("Current Turn:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 20))
                                    .frame(width: 130)
                                
                                Text("\(playerList[currentTurn].name)")
                                    .font(Font.custom("Quicksand-Regular", size: 20))
                            }
                            
                            HStack {
                                Text("No. Turn:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 20))
                                    .frame(width: 130)
                                
                                Text("\(playerList[currentTurn].numberOfTurn)")
                                    .font(Font.custom("Quicksand-Regular", size: 20))
                            }
                            
                            HStack {
                                Text("Score:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 20))
                                    .frame(width: 130)
                                
                                Text("\(playerList[currentTurn].score)")
                                    .font(Font.custom("Quicksand-Regular", size: 20))
                            }
                            
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                
                VStack(spacing: sizeCategory == .small ? 20 : 30) {
                    HStack {
                        if !playerList.isEmpty {
                            if numberOfPlayers == 2 && playerList[1].countinuePlay {
                                CardList(cards:  playerList[1].cards, position: "top",screenSize: sizeCategory)
                            } else if numberOfPlayers > 2 && playerList[2].countinuePlay {
                                CardList(cards:  playerList[2].cards, position: "top", screenSize: sizeCategory)
                            } else {
                                Spacer()
                            }
                        }
                    }
                    .frame(height: geometry.size.height/3 - 50)
                    
                    HStack {
                        if numberOfPlayers > 3 && !playerList.isEmpty && playerList[3].countinuePlay {
                            CardList(cards: playerList[3].cards, position: "left", screenSize: sizeCategory)
                        } else {
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            if !playerList.isEmpty {
                                PickCardList(cardGame: $cardGame, playTurn: $playTurn, playerCards: $playerList[0].cards, currentTurn: $currentTurn, playerList: $playerList, droppedCards: $droppedCards, winGame: $winGame, stealCard: $stealCard, showTurn: $showTurn, isGameDataAvailable: $isGameDataAvailable, numberOfPlayers: numberOfPlayers, aiTurn: aiTurn, screenSize: sizeCategory)
                                    .onChange(of: currentTurn, initial: true) {
                                        checkWin()
                                        saveGameDataToUserDefaults()
                                    }
                                    
                                
                                DropDestination(droppedCards: $droppedCards, screenSize: sizeCategory)
                            }
                        }
                        
                        Spacer()
                        
                        if numberOfPlayers > 2 && !playerList.isEmpty && playerList[1].countinuePlay {
                            CardList(cards: playerList[1].cards, position: "right", screenSize: sizeCategory)
                        } else {
                            Spacer()
                        }
                    }
                    .frame(height: geometry.size.height / 3 + 40)
                    .zIndex(1)
                    
                    if !playerList.isEmpty {
                        ZStack {
                            if showTurn {
                                Image("turn")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .scaledToFit()
                                    .offset(x: 0, y: sizeCategory == .small ? -100 : sizeCategory == .medium ? -120 : -150)
                                    .scaleEffect(showTurn ? 1 : 0.5) // Adjust the scale effect for animation
                                    .opacity(showTurn ? 1 : 0)
                            }
                            
                            HStack(spacing: playerList[0].cards.count < 10 ? -80 : -100) {
                                ForEach(playerList[0].cards.indices, id: \.self) { index in
                                    let card = playerList[0].cards[index]
                                    DraggableCard( card: card, dropZoneFrame: geometry.frame(in: .global), currentTurn: $currentTurn, playerList: $playerList, playTurn: $playTurn, seeFuture: $seeFuture, stealOther: $stealOther, cardGame: $cardGame,  cardOffset: $cardOffsets[index], droppedCards: $droppedCards, playerCards: $playerList[0].cards, currentScore: $currentScore, screenSize: sizeCategory)
                                }
                            }
                            .onChange(of: playerList[0].cards.count, initial: true) {
                                oldValue, newValue in
                                cardOffsets = Array(repeating: .zero, count: playerList[0].cards.count + 1)
                            }
                        }
                        .zIndex(100)

                    }
                }
                
                if !showInput {
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            Spacer()
                            
                            
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Image(systemName: "info.circle")
                                    .padding(20)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("custom-black"))
                            })
                            .sheet(isPresented: $showingSheet) {
                                TabViewCardDescription( showingSheet: $showingSheet, theme: $theme)
                                    .presentationDetents([.medium, .medium, .fraction(0.1)])
                            }
                        }
                        
                    }
                    .padding(.vertical, sizeCategory == .small ? 30 : 0)
                }
                
                                
                if seeFuture && !cardGame.isEmpty {
                    SeeFutureDialog(seeFuture: $seeFuture, cards: cardGame)
                }
                
                if winGame != nil {
                    if winGame! {
                        WinView()
                    }
                    
                }
                
                if winGame != nil {
                    if !winGame! {
                        GameOverView()
                    }
                    
                }
                
                if stealCard && !playerList.isEmpty {
                    PickStealCard(playerCards: $playerList[0].cards, playerList: $playerList, currentTurn: $currentTurn, stealCard: $stealCard, screenSize: sizeCategory)
                }
                
                if stealOther && playerList.count > 2 {
                    PickStealPlayer(playerCard: $playerList[0].cards, playerList: $playerList, currentTurn: $currentTurn, stealOther: $stealOther, screenSize: sizeCategory)
                }
                
                if showInput {
                    InputInfo(playerName: $playerName, numberOfPlayers: $numberOfPlayers, showInput: $showInput)
                }
            }
            .navigationBarBackButtonHidden(true)

            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                if resumeGame {
                    loadGameDataFromUserDefaults()
                } else {
                    isGameDataAvailable = false
                    removeGameDataFromUserDefaults()
                }
          
            }
            .onChange(of: showInput, initial: true) {
                oldValue, newValue in
                if oldValue != newValue {
                    if UserDefaults.standard.data(forKey: "gameData") == nil {
                        let cardList = theme == "Rabbit" ? cardsV2 : cards
                        getCardsForGame(to: &cardGame, numberOfPlayers: numberOfPlayers, level: modeGame, cardList: cardList)
                        setUpPlayers()
                        cardOffsets = Array(repeating: .zero, count: cardGame.count)
                    }
                    
                }
            }
            .onDisappear {
                if playerName != "" && winGame != false && winGame != true {
                    saveGameDataToUserDefaults()
                    isGameDataAvailable = true
                } else {
                    UserDefaults.standard.removeObject(forKey: "gameData")
                    isGameDataAvailable = false
                }
            }

        }
    }
    
    func setUpPlayers() {
        playerList = [Player(name: playerName, cards: [], index: 0, countinuePlay: true)]
        getCardForPlayer(to: &playerList[0].cards, from: &cardGame)
        for i in 1..<numberOfPlayers {
            playerList.append(Player(name: "aiPlayer\(i)", cards: [], index: i, countinuePlay: true))
            getCardForPlayer(to: &playerList[i].cards, from: &cardGame)
        }
    }
    
    
    func aiTurn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if currentTurn != 0 {
                if stealCard {
                    // Wait until stealCard is false before proceeding
                    waitForStealCard(stealCard: stealCard) {
                        self.performAiTurnActions()
                    }
                } else {
                    self.performAiTurnActions()
            }
            }
        }
    }
    
    func performAiTurnActions() {
        if playerList[currentTurn].countinuePlay {
            withAnimation(.spring()) {
                let playCard = playRandomCard(from: &playerList[currentTurn].cards, to: &droppedCards)
                audioManager.playSoundEffect(sound: "play-card", type: "mp3")

                if let playCard = playCard {
                    checkCard(card: playCard, currentTurn: currentTurn, players: &playerList, cardGame: &cardGame, numberOfPlayers: numberOfPlayers) {
                        shouldSteal in
                            stealCard = shouldSteal
                    }
                }
                

                for _ in 0..<playerList[currentTurn].numberOfTurn {
                    if !cardGame.isEmpty {
                        let card = cardGame[cardGame.count - 1]
                        
                        getRandomCard(card: card, to: &playerList[currentTurn].cards, from: &cardGame)
                        audioManager.playSoundEffect(sound: "pick-card", type: "mp3")

                        if card.name == "Bomb" {
                            addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerList[currentTurn].cards)
                            
                            if let defuseCard = playerList[currentTurn].cards.first(where: { $0.name == "Defuse" }) {
                                
                                addCard(card: defuseCard, count: 1, to: &droppedCards, remove: true, from: &playerList[currentTurn].cards)

                                addCard(card: card, count: 1, to: &cardGame, remove: true, from: &droppedCards)
                            } else {
                                playerList[currentTurn].countinuePlay = false
                                stealCard = false
                            }
                        }
                    }
                }
                playerList[currentTurn].numberOfTurn = 1
               
            }
            currentTurn = (currentTurn + 1) % numberOfPlayers
        } else {
            currentTurn = (currentTurn + 1) % numberOfPlayers
        }
    }
    
    
    
    func checkWin() {
        var checking = true
        
        for index in 1..<playerList.count {
            if playerList[index].countinuePlay {
                checking = false
                break
            }
        }
        
        if checking {
            stealCard = false
            winGame = true
            audioManager.playSoundEffect(sound: "winning", type: "mp3")
            updatePlayerResult(name: playerName, didWin: true, score: playerList[0].score)
            removeGameDataFromUserDefaults()
            isGameDataAvailable = false
        }
    }
    
    
    
    func saveGameDataToUserDefaults() {
        let gameData = GameData(
            playerName: self.playerName,
            playerList: self.playerList,
            cardGame: self.cardGame,
            droppedCards: self.droppedCards,
            playTurn: self.playTurn,
            currentTurn: self.currentTurn,
            stealCard: self.stealCard,
            seeFuture: self.seeFuture,
            stealOther: self.stealOther,
            showTurn: self.showTurn,
            showInput: self.showInput,
            numberOfPlayers: self.numberOfPlayers,
            cardOffsets: self.cardOffsets,
            modeGame: self.modeGame
        )
        
        if let encodedData = try? JSONEncoder().encode(gameData) {
            UserDefaults.standard.set(encodedData, forKey: "gameData")
            print("Game data saved to UserDefaults.")
        } else {
            print("Failed to save game data.")
        }
    }
    
    func loadGameDataFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "gameData"),
           let decodedData = try? JSONDecoder().decode(GameData.self, from: savedData) {
            // Assign the decoded data to the state variables
            self.playerName = decodedData.playerName
            self.playerList = decodedData.playerList
            self.cardGame = decodedData.cardGame
            self.droppedCards = decodedData.droppedCards
            self.playTurn = decodedData.playTurn
            self.currentTurn = decodedData.currentTurn
            self.stealCard = decodedData.stealCard
            self.seeFuture = decodedData.seeFuture
            self.stealOther = decodedData.stealOther
            self.showTurn = decodedData.showTurn
            self.showInput = decodedData.showInput
            self.numberOfPlayers = decodedData.numberOfPlayers
            self.cardOffsets = decodedData.cardOffsets
            self.modeGame = decodedData.modeGame
            print("Game data loaded from UserDefaults.")
        } else {
            print("No saved game data found in UserDefaults.")
        }
    }
    
}

#Preview {
//    GameView(numberOfPlayers: 2)
    MenuView()
//    GameView(isGameDataAvailable: .constant(true), modeGame: .constant("Hard"), resumeGame: false)
//        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//        .environmentObject(AudioManager())  Inject the LocalizationManager for the preview

}



