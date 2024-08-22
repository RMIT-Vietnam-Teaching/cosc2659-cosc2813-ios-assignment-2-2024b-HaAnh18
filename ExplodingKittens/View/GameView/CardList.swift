//
//  CardList.swift
//  ExplodingKitten
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct CardList: View {
    var cards: [Card]
    var position: String
    var screenSize: ScreenSizeCategory
    @State private var cardSize: CGFloat? = nil
    
    var body: some View {
        
        if position == "top" {
//            Text("\(screenSize)")
            HStack(spacing: -60) {
                ForEach(cards, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: cardSize , height: cardSize)
                        .scaledToFit()
                        .rotationEffect(.degrees(position == "top" ? 180 : position == "left" ? 90 : -90))
                }
                .padding(.vertical, -7)
            }
            .offset(y: -10)
            .onAppear {
                setComponentSize()
            }
        } else {
            VStack(spacing: -70) {
                ForEach(cards, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: cardSize, height: cardSize)
                        .scaledToFit()
                        .rotationEffect(.degrees(position == "top" ? 180 : position == "left" ? 90 : -90))
                }
            }
            .onAppear {
                setComponentSize()
            }
            .frame(width: position == "top" ? 300 : 80, height: position == "top" ? 80 : 200)
            .padding(0)
        }
    }
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            cardSize = 90
        case .medium:
            cardSize = 110
        case .large:
            if position == "top" {
                cardSize = 180
            } else {
                cardSize = 150
            }
        case .extraLarge:
            cardSize = 120
        }
    }
}

#Preview {
    MenuView()
//    CardList(cards: cards, position: "right")
//    GameView(numberOfPlayers: 4)
}
