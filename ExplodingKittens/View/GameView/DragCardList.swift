//
//  DragCardList.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct DragCardList: View {
    @State private var cardSize: CGFloat? = nil
    @State private var paddingSize: CGFloat = 80
    @Binding var playerCards: [Card]
    @Binding var draggedCard: Card?
    var screenSize: ScreenSizeCategory

//    @Binding var playerList: [Player]
//    @Binding var currentTurn: Int
    
    var body: some View {
        GeometryReader {
            let size = $0.size  // Get the size of the geometry

            VStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: -60) {
                        ForEach(playerCards.indices, id: \.self) { index in
                            let card = playerCards[index]
                                card.frontImage
                                    .resizable()
                                    .frame(width: cardSize, height: cardSize)
                                    .padding(-14)
                                    .scaledToFit()
                                    .onDrag {
                                        self.draggedCard = card
                                        return NSItemProvider(object: String(index) as NSString)
                                    }
                                    .onDrop(of: ["public.text"], delegate: DropViewDelegate(destinationIndex: index, cards: $playerCards, draggedCard: $draggedCard))
                        }
                    }
    //                .offset(y: 10)
                    .padding(.horizontal, max((size.width - (CGFloat(playerCards.count) * paddingSize + CGFloat(playerCards.count - 1) * -20)) / 2, 0))
                })
            }

        }
        .onAppear {
            setComponentSize()
        }
//        .background(.green)
//        .frame(height: 300)
    }
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            cardSize = 150
            paddingSize = 80
        case .medium:
            cardSize = 180
            paddingSize = 110
        case .large:
            cardSize = 200
            paddingSize = 130
        case .extraLarge:
            cardSize = 120
            paddingSize = 100
        }
    }
}

#Preview {
//    DragCardList(playerCards: .constant(cards), draggedCard: .constant(cards[0]))
    GameView(numberOfPlayers: 4)
}
