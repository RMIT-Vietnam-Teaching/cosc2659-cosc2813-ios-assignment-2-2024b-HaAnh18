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
//                    .frame(width: size.width / 2 + 300, height: size.height - 50)
                    .frame(width: widthRecSize, height: heightRecSize)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
                    .foregroundColor(.white)
                
                VStack {
                    Button(action: {
                        chosenPlayer = 2
                    }, label: {
                        CardList(cards: playerList[2].cards, position: "top", screenSize: screenSize)
                            .shadow(color: .blue, radius: playerList[chosenPlayer] == playerList[2] ? 10 : 0)
                    })
                    
                    HStack {
                        Spacer()
                        if playerList.count > 3 {
                            Button(action: {
                                chosenPlayer = 3
                            }, label: {
                                CardList(cards: playerList[3].cards, position: "left", screenSize: screenSize)
                                    .shadow(color: .blue, radius: playerList[chosenPlayer] == playerList[3] ? 10 : 0)
                            })
                        }
                        
                        Spacer()
                        
                        Text("Please choose a player to steal")
                        
                        Spacer()
                        if playerList.count > 2 {
                            Button(action: {
                                chosenPlayer = 1
                            }, label: {
                                CardList(cards: playerList[1].cards, position: "left", screenSize: screenSize)
                                    .shadow(color: .blue, radius: playerList[chosenPlayer] == playerList[1] ? 10 : 0)
                            })
                        }
                        Spacer()

                        
                    }
                    .offset(y: -50)
                    
                    if chosenPlayer != 0 {
                        Button("Confirm") {
                            withAnimation {
                                aiGiveCard(to: &playerCard, from: &playerList[chosenPlayer].cards)
                                stealOther = false
                            }
                        }
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
            widthRecSize = 600
            heightRecSize = 300
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

#Preview {
//    PickStealPlayer()
    GameView(numberOfPlayers: 4)
}
