//
//  PickStealPlayer.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//

import SwiftUI

struct PickStealPlayer: View {
    @Binding var playerCard: [Card]
    @Binding var playerList: [Player]
    @Binding var currentTurn: Int
    @Binding var stealOther: Bool
    @State private var chosenPlayer: Int = 0
    @State private var isVisible = false
    @State private var widthRecSize: CGFloat = 10
    @State private var heightRecSize: CGFloat = 10
    
    var screenSize: ScreenSizeCategory
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: widthRecSize, height: heightRecSize)
                    .foregroundColor(.white)
                
                VStack(spacing: -10) {
                    Button(action: {
                        chosenPlayer = 2
                    }, label: {
                        CardList(cards: playerList[2].cards, position: "top", screenSize: screenSize)
                            .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[2] ? 10 : 0)
                    })
                    
                    HStack {
                        Spacer()
                        if playerList.count > 3 {
                            Button(action: {
                                chosenPlayer = 3
                            }, label: {
                                CardList(cards: playerList[3].cards, position: "left", screenSize: screenSize)
                                    .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[3] ? 10 : 0)
                            })
                        }
                        
                        Spacer()
                        
                        Text("Please choose a player to steal")
                            .font(Font.custom("Quicksand-Bold", size: 24))

                        
                        Spacer()
                        if playerList.count > 2 {
                            Button(action: {
                                chosenPlayer = 1
                            }, label: {
                                CardList(cards: playerList[1].cards, position: "left", screenSize: screenSize)
                                    .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[1] ? 10 : 0)
                            })
                        }
                        Spacer()
                    }
                    .offset(y: -20)
                    
                    if chosenPlayer != 0 {
                        Button("Confirm") {
                            withAnimation {
                                aiGiveCard(to: &playerCard, from: &playerList[chosenPlayer].cards)
                                stealOther = false
                            }
                        }
                        .modifier(confirmButton())
                    }
                }
            }
            .ignoresSafeArea()
            .frame(width: size.width, height: size.height)
            .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isVisible = true
                    setComponentSize()
                }
            }
        }
    }
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            widthRecSize = 700
            heightRecSize = 350
        case .medium:
            widthRecSize = 700
            heightRecSize = 350
        case .large:
            widthRecSize = 700
            heightRecSize = 300
        case .extraLarge:
            widthRecSize = 120
            heightRecSize = 200
        }
    }
}

//#Preview {
//    PickStealPlayer()
//    MenuView()
//    PickStealCard(playerCards: .constant(cards), playerList: <#T##[Player]#>, currentTurn: <#T##Int#>, stealCard: <#T##Bool#>, screenSize: <#T##ScreenSizeCategory#>)

//    GameView(isGameDataAvailable: .constant(false), resumeGame: false)
//}

var players: [Player] = [
    Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 0, lose: 0, level: 10), // Level 10, Win rate 70%
    Player(name: "Alice", cards: cards, numberOfTurn: 1, index: 1, countinuePlay: true, win: 9, lose: 1, level: 1),
    Player(name: "Bob", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5),
    Player(name: "A", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5)
   ]

struct PickStealCard_Previews: PreviewProvider {
//    @StateObject static var viewModel = ViewModel()
    
    
    static var previews: some View {
        PickStealPlayer(playerCard: .constant(cards), playerList: .constant(players), currentTurn: .constant(0), stealOther: .constant(true), screenSize: .small)
    }
}
