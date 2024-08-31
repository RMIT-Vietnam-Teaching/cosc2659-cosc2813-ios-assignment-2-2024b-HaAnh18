//
//  BombPosition.swift
//  ExplodingKittens
//
//  Created by Nana on 31/8/24.
//

import SwiftUI

struct BombPosition: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var open: Bool = false
    @State private var isVisible = false
    @State private var position: Int?
    @State private var choice: String?
    
    @Binding var playerCards: [Card]
    @Binding var droppedCards: [Card]
    @Binding var cardGame: [Card]
    @Binding var bombCard: Card?
    @Binding var currentTurn: Int
    @Binding var playerList: [Player]

    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.1)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 300, height: 350)
                    .foregroundColor(Color("custom-white"))
                
                VStack(spacing: 20) {
                    Text("Set Bomb Back", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 32))
                        .foregroundColor(Color("custom-black"))
                    
                    Button(action: {
                        position = cardGame.count
                        choice = "Top"
                    }, label: {
                        Text("Top")
                            .modifier(choice == "Top" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    Button(action: {
                        position = 0
                        choice = "Bottom"
                    }, label: {
                        Text("Bottom")
                            .modifier(choice == "Bottom" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    Button(action: {
                        position = Int.random(in: 0...cardGame.count)
                        choice = "Random"
                    }, label: {
                        Text("Random")
                            .modifier(choice == "Random" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    if position != nil {
                        Button(action: {
                            cardGame.insert(bombCard!, at: position!)
                            bombCard = nil
                            playerList[currentTurn].numberOfTurn -= 1
                            
                            if playerList[currentTurn].numberOfTurn == 0 {
                                playerList[currentTurn].numberOfTurn = 1
                                currentTurn = (currentTurn + 1) % playerList.count
                            }
                        }, label: {
                            Text("Confirm")
                                .modifier(confirmButton())
                        })
                    }
                }
             
                
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                isVisible = true
            }
            
            withAnimation(.easeInOut(duration: 1.0)) {
                open = true
            }
            

        }
        .opacity(isVisible ? 1 : 0)
    }
}

#Preview {
//    BombPosition()
    MenuView()
    
}
