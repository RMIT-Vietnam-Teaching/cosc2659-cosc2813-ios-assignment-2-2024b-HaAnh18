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
    @State private var defaultMode: String = "Easy"
    @State private var cardOffsets: [CGSize] = []
    @State private var bombCard: Card?
    @State private var percentBomb: CGFloat = 0
    @State private var level: Int = 1
    
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
                
                HStack(alignment: .top) {
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
                    
                    if !playerList.isEmpty  {
                        VStack {
                            HStack {
                                HStack {
                                    Spacer()
                                    Text("Current Turn:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Medium", size: 20))
                                        
                                }
                                .frame(width: 130)
                                
                                if playerList[currentTurn].countinuePlay {
                                    Text("\(playerList[currentTurn].name)")
                                        .font(Font.custom("Quicksand-Regular", size: 20))
                                        .frame(width: 100)
                                } else {
                                    Spacer()
                                        .frame(width: 100)
                                }
                                
                            }
                            .frame(width: 230)
                            
                            HStack {
                                HStack {
                                    Spacer()

                                    Text("No. Turn:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Medium", size: 20))
                                }
                                .frame(width: 130)

                                if playerList[currentTurn].countinuePlay {
                                    Text("\(playerList[currentTurn].numberOfTurn)")
                                        .font(Font.custom("Quicksand-Regular", size: 20))
                                        .frame(width: 100)
                                } else {
                                    Spacer()
                                        .frame(width: 100)
                                }
                                
                            }
                            .frame(width: 230)
                            
                            HStack {
                                HStack {
                                    Spacer()
                                    Text("Score:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Medium", size: 20))
                                }
                                .frame(width: 130)
                                
                                if playerList[currentTurn].countinuePlay {
                                    Text("\(playerList[currentTurn].score)")
                                        .font(.custom("Quicksand-Regular", size: 20))
                                        .frame(width: 100)
                                } else {
                                    Spacer()
                                        .frame(width: 100)
                                }
                                
                            }
                            .frame(width: 230)
                            
                            HStack {
                                HStack {
                                    Spacer()
                                    
                                    Text("Level:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Medium", size: 20))
                                }
                                .frame(width: 130)
                                
                                if playerList[currentTurn].countinuePlay {
                                    Text("\(level)")
                                        .font(Font.custom("Quicksand-Regular", size: 20))
                                        .frame(width: 100)
                                } else {
                                    Spacer()
                                        .frame(width: 100)
                                }

                                
                            }
                            .frame(width: 230)
                            
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                
                VStack(spacing: sizeCategory == .small ? 20 : 30) {
                    HStack {
                        if !playerList.isEmpty {
                            if numberOfPlayers == 2 && playerList[1].countinuePlay {
                                // If there are 2 players and the second player (index 1) is continuing to play:
                                // Display the second player's cards at the "top" position using the CardList view.
                                CardList(cards:  playerList[1].cards, position: "top",screenSize: sizeCategory)
                            } else if numberOfPlayers > 2 && playerList[2].countinuePlay {
                                // If there are more than 2 players and the third player (index 2) is continuing to play:
                                // Display the third player's cards at the "top" position using the CardList view.
                                CardList(cards:  playerList[2].cards, position: "top", screenSize: sizeCategory)
                            } else {
                                // If neither of the above conditions are met:
                                // Insert a Spacer to take up space and ensure proper layout.
                                Spacer()
                            }
                        }
                    }
                    .frame(height: geometry.size.height / 3 - 40)
                    
                    HStack {
                        if numberOfPlayers > 3 && !playerList.isEmpty && playerList[3].countinuePlay {
                            CardList(cards: playerList[3].cards, position: "left", screenSize: sizeCategory)
                        } else {
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            if !playerList.isEmpty {
                                BombPercent(percent: $percentBomb)
                                    .onChange(of: cardGame.count, initial: true) {
                                        // The onChange modifier listens for changes in the cardGame.count.
                                        // When the number of cards in cardGame changes, this closure is triggered.
                                        
                                        // Calculate the percentage of "Bomb" cards in the current cardGame array
                                        // and update the percentBomb state variable accordingly.
                                        percentBomb = calculateBombPercent(cards: cardGame)
                                    }
                                
                                // Custom view that handles the card picking logic and related game state.
                                PickCardList(cardGame: $cardGame, playTurn: $playTurn, playerCards: $playerList[0].cards, currentTurn: $currentTurn, playerList: $playerList, droppedCards: $droppedCards, winGame: $winGame, stealCard: $stealCard, showTurn: $showTurn, isGameDataAvailable: $isGameDataAvailable,  bomb: $bombCard, numberOfPlayers: numberOfPlayers, aiTurn: aiTurn, screenSize: sizeCategory)
                                    .onChange(of: currentTurn, initial: true) {
                                        // This block is executed whenever the currentTurn value changes, and also initially when the view appears.

                                        checkWin() // Calls a function to check if the game has been won
                                        saveGameDataToUserDefaults()  // Saves the current game state to UserDefaults for persistence.
                                    }
                                
                                // DropDestination is a custom view that likely represents an area where cards can be dropped by the player.
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
                            
                            let spacingIphone = playerList[0].cards.count < 10 ? -80 : -100
                            
                            let spacingIpad = playerList[0].cards.count < 8 ? -100 : -150
                            HStack(spacing: sizeCategory == .large ? CGFloat(spacingIpad) : CGFloat(spacingIphone)) {
                                ForEach(playerList[0].cards.indices, id: \.self) { index in
                                    let card = playerList[0].cards[index]
                                    // Retrieve the card at the current index in the loop.

                                    DraggableCard( card: card, dropZoneFrame: geometry.frame(in: .global), currentTurn: $currentTurn, playerList: $playerList, playTurn: $playTurn, seeFuture: $seeFuture, stealOther: $stealOther, cardGame: $cardGame,  cardOffset: $cardOffsets[index], droppedCards: $droppedCards, playerCards: $playerList[0].cards, currentScore: $currentScore, screenSize: sizeCategory)
                                }
                            }
                            .frame(height: geometry.size.height / 3)
                            .onChange(of: playerList[0].cards.count, initial: true) {
                                oldValue, newValue in
                                // When the number of cards in the first player's hand (playerList[0].cards.count) changes,
                                // this block of code will be executed.
                                
                                // Create an array of CGPoint values (cardOffsets) initialized with .zero (which is (0, 0)).
                                // The length of this array is one more than the current number of cards in the first player's hand.
                                // This is likely used to track or manage the positions or offsets of the cards on the screen.
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
                                    .padding(10)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("custom-black"))
                            })
                            .sheet(isPresented: $showingSheet) {
                                TabViewCardDescription( showingSheet: $showingSheet, theme: $theme)
                                    .presentationDetents([.medium, .medium, .fraction(0.1)])
                            }
                        }
                        
                    }
                    .padding(.vertical, sizeCategory == .small ? 30 : 50)
                }
                
                                
                if seeFuture && !cardGame.isEmpty {
                    SeeFutureDialog(seeFuture: $seeFuture, cardList: cardGame)
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
                
                if bombCard != nil && !playerList.isEmpty {
                    BombPosition(playerCards: $playerList[0].cards, droppedCards: $droppedCards, cardGame: $cardGame, bombCard: $bombCard, currentTurn: $currentTurn, playerList: $playerList)
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
                    // If the game is resuming from a saved state

                    loadGameDataFromUserDefaults()
                    // Load the game data from UserDefaults, restoring the game to its previous state.

                    if currentTurn != 0 {
                        // If the current turn is not the first player's turn (indicated by currentTurn != 0)
                        aiTurn()
                    } else {
                        // Set playTurn to true, indicating that it's time for the first player to play their turn.
                        playTurn = true
                    }
                } else {
                    // If the game is not resuming (indicating a new game is starting)
                    isGameDataAvailable = false // Set isGameDataAvailable to false, indicating that there is no saved game data available.

                    // Remove any existing game data from UserDefaults, ensuring the game starts fresh.
                    removeGameDataFromUserDefaults()
                }
          
            }
            .onChange(of: showInput, initial: true) {
                oldValue, newValue in
                // Check if the value of 'showInput' has actually changed.
                if oldValue != newValue {
                    // If there is no saved game data in UserDefaults, proceed with setting up a new game.
                    if UserDefaults.standard.data(forKey: "gameData") == nil {
                        
                        // Choose the card list based on the current theme.
                        // If the theme is "Rabbit", use 'cardsV2'; otherwise, use 'cards'
                        let cardList = theme == "Rabbit" ? cardsV2 : cards
                        
                        // If a player with the specified 'playerName' exists, retrieve their level.
                        if let player = getPlayer(name: playerName) {
                            level = player.level
                        }
                        
                        // Set up the cards for the game using the selected card list, number of players, game mode, and player level.
                        getCardsForGame(to: &cardGame, numberOfPlayers: numberOfPlayers, mode: modeGame, cardList: cardList, level: level)
                        
                        // Set up the players for the game. This likely involves initializing their hands, scores, and other relevant data.
                        setUpPlayers()
                        
                        // Initialize 'cardOffsets' as an array of CGPoint values (all set to .zero) with a length equal to the number of cards in 'cardGame'.
                        cardOffsets = Array(repeating: .zero, count: cardGame.count)
                        
                        // Calculate the percentage of "Bomb" cards in the 'cardGame' deck and store it in 'percentBomb'.
                        percentBomb = calculateBombPercent(cards: cardGame)
                    }
                }
            }
            .onDisappear {
                // Check if the playerName is not empty AND the game has not been won or lost yet.
                // 'winGame' being neither false nor true likely indicates that the game is still ongoing.
                if playerName != "" && winGame != false && winGame != true {
                    saveGameDataToUserDefaults()
                    isGameDataAvailable = true
                } else {
                    // Remove any existing game data from UserDefaults to prevent resuming an invalid or completed game.
                    removeGameDataFromUserDefaults()
                    
                    // Set 'isGameDataAvailable' to false, indicating that there is no saved game data available.
                    isGameDataAvailable = false
                }
            }
        }
    }
    
    func setUpPlayers() {
        // Initialize human player and add to playerList.
        playerList = [Player(name: playerName, cards: [], index: 0, countinuePlay: true)]
        getCardForPlayer(to: &playerList[0].cards, from: &cardGame)
        
        // Add AI players and deal cards to them.
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
    
    // This function handles the AI's actions during its turn.
    func performAiTurnActions() {
        // Check if the current AI player is still in the game (i.e., can continue playing).
        if playerList[currentTurn].countinuePlay {
            // Perform the AI's actions with a spring animation for smoother UI transitions.
            withAnimation(.spring()) {
                // The AI plays a random card from its hand.
                let playCard = playRandomCard(from: &playerList[currentTurn].cards, to: &droppedCards)
                
                // Play a sound effect when the card is played.
                audioManager.playSoundEffect(sound: "play-card", type: "mp3")

                if let playCard = playCard {
                    checkCard(card: playCard, currentTurn: currentTurn, players: &playerList, cardGame: &cardGame, numberOfPlayers: numberOfPlayers) {
                        shouldSteal in
                        // If the card effect includes a steal action, update the stealCard state.
                            stealCard = shouldSteal
                    }
                }
                
                // The AI draws a number of cards equal to its number of turns.
                for _ in 0..<playerList[currentTurn].numberOfTurn {
                    if !cardGame.isEmpty {
                        let card = cardGame[cardGame.count - 1]
                        
                        // The AI picks this card from the deck.
                        getRandomCard(card: card, to: &playerList[currentTurn].cards, from: &cardGame)
                        
                        // Play a sound effect when the card is picked.
                        audioManager.playSoundEffect(sound: "pick-card", type: "mp3")

                        // If the AI draws a "Bomb" card
                        if card.name == "Bomb" {
                            addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerList[currentTurn].cards)
                            
                            // Check if the AI has a "Defuse" card to defuse the bomb.
                            if let defuseCard = playerList[currentTurn].cards.first(where: { $0.name == "Defuse" }) {
                                
                                addCard(card: defuseCard, count: 1, to: &droppedCards, remove: true, from: &playerList[currentTurn].cards)

                                // Place the "Bomb" card back into the deck at the first position.
                                addCard(card: card, count: 1, to: &cardGame, remove: true, from: &droppedCards)
                            } else {
                                // If no "Defuse" card is found, the AI player is out of the game.
                                playerList[currentTurn].countinuePlay = false
                                stealCard = false
                            }
                        }
                    }
                }
                // Reset the AI's number of turns to 1 after its turn is over.
                playerList[currentTurn].numberOfTurn = 1
            }
            // Move to the next player's turn.
            currentTurn = (currentTurn + 1) % numberOfPlayers
        } else {
            // If the AI player cannot continue, move to the next player.
            currentTurn = (currentTurn + 1) % numberOfPlayers
        }
    }
    
    func checkWin() {
        var checking = true
        
        // Loop through all AI players (starting from index 1 because index 0 is the human player).
        for index in 1..<playerList.count {
            // If any AI player can still continue playing (i.e., countinuePlay is true),
            // set 'checking' to false and break out of the loop
            if playerList[index].countinuePlay {
                checking = false
                break
            }
        }
        
        // If 'checking' remains true after the loop, it means no AI players can continue playing, so the human player wins.
        if checking {
            stealCard = false
            
            // Set the winGame flag to true, indicating that the human player has won the game.
            winGame = true
            
            // Play a sound effect to celebrate the win.
            audioManager.playSoundEffect(sound: "winning", type: "mp3")
            
            // Update the player's record with a win and their final score.
            updatePlayerResult(name: playerName, didWin: true, score: playerList[0].score)
            
            // Remove the game data from UserDefaults since the game is over and no longer needs to be resumed.
            removeGameDataFromUserDefaults()
            
            // Set the flag to indicate that there is no game data available for resumption.
            isGameDataAvailable = false
        }
    }
    
    func saveGameDataToUserDefaults() {
        // Create an instance of the GameData struct, which contains all relevant game state information.
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
            modeGame: self.modeGame,
            bombCard: self.bombCard,
            percentBomb: self.percentBomb,
            level: self.level
        )

        // Attempt to encode the GameData instance into JSON.
        if let encodedData = try? JSONEncoder().encode(gameData) {
            // If encoding is successful, save the encoded data to UserDefaults under the key "gameData".
            UserDefaults.standard.set(encodedData, forKey: "gameData")
            print("Game data saved to UserDefaults.")
        } else {
            // If encoding fails, log an error message.
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
            self.bombCard = decodedData.bombCard
            self.percentBomb = decodedData.percentBomb
            self.level = decodedData.level
            print("Game data loaded from UserDefaults.")
        } else {
            print("No saved game data found in UserDefaults.")
        }
    }
    
}

#Preview {
    MenuView()
}



