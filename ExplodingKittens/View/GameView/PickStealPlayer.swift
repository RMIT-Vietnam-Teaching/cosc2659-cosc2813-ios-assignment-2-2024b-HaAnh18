//
//  PickStealPlayer.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
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

struct PickStealPlayer: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var playerCard: [Card]
    @Binding var playerList: [Player]
    @Binding var currentTurn: Int
    @Binding var stealOther: Bool
    @State private var chosenPlayer: Int = 0
    @State private var isVisible = false
    
    var screenSize: ScreenSizeCategory
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                let widthRecSize = screenSize == .large ? 900 : 720

                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: CGFloat(widthRecSize), height: 350)
                    .foregroundColor(Color("custom-white"))
                
                VStack(spacing: -10) {
                    Button(action: {
                        chosenPlayer = 2
                    }, label: {
                        CardList(cards: playerList[2].cards, position: "top", screenSize: .medium)
                            .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[2] ? 10 : 0)
                    })
                    
                    HStack {
                        Spacer()
                        if playerList.count > 3 {
                            Button(action: {
                                chosenPlayer = 3
                            }, label: {
                                CardList(cards: playerList[3].cards, position: "left", screenSize: .medium)
                                    .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[3] ? 10 : 0)
                            })
                        }
                        
                        Spacer()
                        
                        Text("Please choose a player to steal", manager: localizationManager)
                            .font(Font.custom("Quicksand-Bold", size: 24))

                        
                        Spacer()
                        if playerList.count > 2 {
                            Button(action: {
                                chosenPlayer = 1
                            }, label: {
                                CardList(cards: playerList[1].cards, position: "left", screenSize: .medium)
                                    .shadow(color: Color("red"), radius: playerList[chosenPlayer] == playerList[1] ? 10 : 0)
                            })
                        }
                        Spacer()
                    }
                    .offset(y: -20)
                    
                    if chosenPlayer != 0 {
                        Button(action: {
                            withAnimation {
                                aiGiveCard(to: &playerCard, from: &playerList[chosenPlayer].cards)
                                stealOther = false
                            }
                        }, label: {
                            Text("Confirm", manager: localizationManager)
                                .modifier(confirmButton())
                        })
                        
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
                }
            }
        }
    }
}

var players: [Player] = [
    Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 0, lose: 0, level: 10), // Level 10, Win rate 70%
    Player(name: "Alice", cards: cards, numberOfTurn: 1, index: 1, countinuePlay: true, win: 9, lose: 1, level: 1),
    Player(name: "Bob", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5),
    Player(name: "A", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5)
   ]

struct PickStealCard_Previews: PreviewProvider {
    
    static var previews: some View {
        PickStealPlayer(playerCard: .constant(cards), playerList: .constant(players), currentTurn: .constant(0), stealOther: .constant(true), screenSize: .small)
            .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
    }
}
