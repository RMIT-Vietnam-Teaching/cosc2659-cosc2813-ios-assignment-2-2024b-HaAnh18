//
//  DragCardList.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct DragCardList: View {
    @Binding var playerCards: [Card]
    @Binding var draggedCard: Card?
//    @Binding var playerList: [Player]
//    @Binding var currentTurn: Int
    
    var body: some View {
        GeometryReader {
            let size = $0.size  // Get the size of the geometry
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: -60) {
                    ForEach(playerCards.indices, id: \.self) { index in
                        let card = playerCards[index]
                            card.frontImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(-14)
                                .scaledToFit()
                                .onDrag {
                                    self.draggedCard = card
                                    return NSItemProvider(object: String(index) as NSString)
                                }
                                .onDrop(of: ["public.text"], delegate: DropViewDelegate(destinationIndex: index, cards: $playerCards, draggedCard: $draggedCard))
                    }
                }
                .offset(y: 10)
                .padding(.horizontal, max((size.width - (CGFloat(playerCards.count) * 80 + CGFloat(playerCards.count - 1) * -20)) / 2, 0))
            })

        }
//        .frame(height: 300)
    }
}

#Preview {
//    DragCardList(playerCards: .constant(cards), draggedCard: .constant(cards[0]))
    GameView(numberOfPlayers: 3)
}
