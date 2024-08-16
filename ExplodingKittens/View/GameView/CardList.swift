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
    var body: some View {
        GeometryReader {
            let size = $0.size  // Get the size of the geometry
            
            if position == "top" {
                HStack(spacing: -60) {
                    ForEach(cards, id: \.self) { card in
                        card.frontImage
                            .resizable()
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                            .rotationEffect(.degrees(position == "top" ? 180 : position == "left" ? 90 : -90))
                    }
                    .padding(.vertical, -7)
                }
                .padding(.horizontal, max((size.width - (CGFloat(cards.count) * 60 + CGFloat(cards.count - 1) * -10)) / 2, 0))
            } else {
                VStack(spacing: -70) {
                    ForEach(cards, id: \.self) { card in
                        card.frontImage
                            .resizable()
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                            .rotationEffect(.degrees(position == "top" ? 180 : position == "left" ? 90 : -90))
                    }
                }
                .padding(.vertical, max((size.width - (CGFloat(cards.count) * 40 + CGFloat(cards.count - 1) * -10)) / 2, 0))
            }
            
        }
        .frame(width: position == "top" ? 300 : 80, height: position == "top" ? 80 : 200)
        .padding(0)
    }
}

#Preview {
//    CardList(cards: cards, position: "right")
    GameView(numberOfPlayers: 4)
}
