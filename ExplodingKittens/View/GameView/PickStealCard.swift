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
    @State private var isVisible = false
    @State var chosenCard: Card?
    @State private var widthRecSize: CGFloat = 10
    @State private var heightRecSize: CGFloat = 10
    
    var screenSize: ScreenSizeCategory

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
//                    .frame(width: size.width / 2 + 300, height: size.height - 100)
                    .frame(width: widthRecSize, height: heightRecSize)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
                    .foregroundColor(.white)
//                    .foregroundColor(.yellow)
                
                VStack(spacing: 20) {
                    Text("Pick a card to give")
                        .font(Font.custom("Quicksand-Bold", size: 32))

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
                                                    .stroke(Color("red"), lineWidth: 2)
                                                    .frame(width: 150, height: 150)
                                            }
                                        }
                                        .onTapGesture {
                                            chosenCard = card
                                        }
                                }
                            }
                        }
                    }
                    .frame(width: widthRecSize - 10)
                    
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
                                    .modifier(confirmButton())
                            })
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
            heightRecSize = 350
        case .medium:
            widthRecSize = 600
            heightRecSize = 350
        case .large:
            widthRecSize = 700
            heightRecSize = 350
        case .extraLarge:
            widthRecSize = 120
            heightRecSize = 200
        }
    }
}

#Preview {
//    PickStealCard(cards: .constant(cards), chosenCard: .constant(cards[0]))
//    MenuView()

    PickStealCard(playerCards: .constant(cards), playerList: .constant([]), currentTurn: .constant(0), stealCard: .constant(true), screenSize: .small)
//    GameView(numberOfPlayers: 4)
}


