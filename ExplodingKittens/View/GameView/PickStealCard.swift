//
//  PickStealCard.swift
//  ExplodingKittens
//
//  Created by Nana on 16/8/24.
//

import SwiftUI

struct PickStealCard: View {
    @Binding var playerCards: [Card]
    @Binding var playerList: [Player]
    @Binding var currentTurn: Int
    @Binding var stealCard: Bool
//    @State private var isVisible = false
    @State var chosenCard: Card?

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: size.width / 2 + 300, height: size.height - 100)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
                    .foregroundColor(.white)
//                    .foregroundColor(.yellow)
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(playerCards, id: \.self) {
                                card in
                                VStack {
                                    card.frontImage
                                        .resizable()
                                        .frame(width: 160, height: 160)
                                        .padding(0)
                                        .overlay {
                                            if chosenCard == card {
                                                RoundedRectangle(cornerRadius: 5.0)
                                                    .stroke(.black, lineWidth: 1)
                                                    .frame(width: 150, height: 150)
                                            }
                                        }
                                
                                    Button(action: {
                                        chosenCard = card
                                    }, label: {
                                        Text("Choose")
                                            .modifier(buttonCapsule())
                                    })
                                }
                                
                            }
                        }
                    }
                    .frame(width: size.width - 100)
                    
                    if chosenCard != nil {
                        withAnimation(.easeIn(duration: 1)) {
                            Button(action: {
                                withAnimation {
                                    addCard(card: chosenCard!, count: 1, to: &playerList[ (currentTurn - 1 + playerList.count) % playerList.count].cards, remove: false, from:  &playerCards)
                                    
                                    removeCard(card: chosenCard!, from: &playerCards)
                                    
                                    stealCard = false
                                }
                            }, label: {
                                Text("Confirm")
                            })
                        }
                    }
                }
               
            }
            .ignoresSafeArea()
            .frame(width: size.width, height: size.height)
//            .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
//            .opacity(isVisible ? 1 : 0)
//            .onAppear {
//                withAnimation(.easeInOut(duration: 1.0)) {
//                    isVisible = true
//                }
//            }
        }
    }
}

#Preview {
//    PickStealCard(cards: .constant(cards), chosenCard: .constant(cards[0]))
    GameView(numberOfPlayers: 4)
}
