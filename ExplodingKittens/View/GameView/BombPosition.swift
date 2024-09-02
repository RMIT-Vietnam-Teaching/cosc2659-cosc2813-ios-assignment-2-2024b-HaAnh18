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
                        // Set the position to the top of the deck (the last position in the cardGame array).
                        position = cardGame.count
                        
                        // Set the choice to "Top", indicating that the user selected this option.
                        choice = "Top"
                    }, label: {
                        Text("Top", manager: localizationManager)
                            .modifier(choice == "Top" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    Button(action: {
                        // Set the position to the bottom of the deck (the first position in the cardGame array).
                        position = 0
                        
                        // Set the choice to "Bottom", indicating that the user selected this option.
                        choice = "Bottom"
                    }, label: {
                        Text("Bottom", manager: localizationManager)
                            .modifier(choice == "Bottom" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    Button(action: {
                        // Set the position to a random value within the range of the deck (from 0 to the last position).
                        position = Int.random(in: 0...cardGame.count)
                        
                        // Set the choice to "Random", indicating that the user selected this option.
                        choice = "Random"
                    }, label: {
                        Text("Random", manager: localizationManager)
                            .modifier(choice == "Random" ? AnyViewModifier(chooseButton()) : AnyViewModifier(buttonCapsule()))
                    })
                    
                    if position != nil {
                        Button(action: {
                            // Insert the bombCard at the specified position in the cardGame deck.
                            cardGame.insert(bombCard!, at: position!)
                            
                            // Reset the bombCard to nil after placing it in the deck.
                            bombCard = nil
                            
                            // Decrease the current player's number of turns by 1.
                            playerList[currentTurn].numberOfTurn -= 1
                            
                            if playerList[currentTurn].numberOfTurn == 0 {
                                // If no turns left, reset their turn count to 1 for the next round.
                                playerList[currentTurn].numberOfTurn = 1
                                
                                // Move to the next player's turn.
                                currentTurn = (currentTurn + 1) % playerList.count
                            }
                        }, label: {
                            Text("Confirm", manager: localizationManager)
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
    MenuView()
}
