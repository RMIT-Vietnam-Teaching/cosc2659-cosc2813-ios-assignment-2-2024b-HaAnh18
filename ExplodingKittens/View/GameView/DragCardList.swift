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
    @Binding var stealCard: Bool
    @Binding var playerList: [Player]
    @Binding var currentTurn: Int
    @State private var offsets: [CGFloat] = []
    @State private var giveCard: Card?
    var body: some View {
        GeometryReader {
            let size = $0.size  // Get the size of the geometry
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: -60) {
                    if !offsets.isEmpty {
                        ForEach(playerCards.indices, id: \.self) { index in
                            let card = playerCards[index]
                            VStack(spacing: 10) {
                                Spacer()
                                
//                                Rectangle()
//                                    .frame(width: 100)
//                                    .foregroundColor(.white)
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
                                    .onTapGesture {
                                        withAnimation {
                                            if stealCard {
                                                if offsets[index] == 10 {
                                                    giveCard = card
                                                } else {
                                                    giveCard = nil
                                                }
                                            }
                                            offsets[index] = offsets[index] == -10 ? 10 : -10
                                            
                                        }
                                    }
                                
                                Spacer()
                                
                                
                            }
                            .offset(y: offsets[index])

                        }
                    }
                    
                    if giveCard != nil && stealCard {
                        Text("Give")
                            .modifier(buttonCapsule())
                            .offset(x: 100)
                            .onTapGesture {
                                withAnimation {
                                    addCard(card: giveCard!, count: 1, to: &playerList[currentTurn].cards, remove: false, from:  &playerCards)
                                    
                                    removeCard(card: giveCard!, from: &playerCards)
                                    
                                    stealCard = false
                                }
                            }

                    }

                   

                }
                .padding(.horizontal, max((size.width - (CGFloat(playerCards.count) * 80 + CGFloat(playerCards.count - 1) * -20)) / 2, 0))
                
                
            })

        }
//        .background(.yellow)
        .frame(height: 300)
        .onAppear {
            offsets = Array(repeating: 10, count: $playerCards.wrappedValue.count)
        }
        .onChange(of: playerCards.count, initial: true, {
            offsets.append(10)
//            offsets = Array(repeating: 10, count: $playerCards.wrappedValue.count)
        })
    }
}

#Preview {
//    DragCardList(playerCards: .constant(cards), draggedCard: .constant(cards[0]))
    GameView(numberOfPlayers: 3)
}
