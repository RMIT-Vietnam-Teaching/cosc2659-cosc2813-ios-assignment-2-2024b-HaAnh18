//
//  TutorialView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//


import SwiftUI

struct PlayCardTutorial: View {
    @State private var cardOffsets: [CGSize] = Array(repeating: .zero, count: cards.count) // For two cards
    @State private var isDragging = Array(repeating: false, count: cards.count)
    @State private var isCardInDropZone = Array(repeating: false, count: cards.count) // Track if each card is in the drop zone
    @State private var cardVisible = Array(repeating: true, count: cards.count) // Track visibility of each card
    @State private var currentCard: Card?
    @State private var pickCards: [Card] = cards.filter {$0.name != "Bomb"}
    @State private var playerCards: [Card] = cards.filter {$0.name != "Bomb"}
    @State private var step1: Bool = true
    @State private var step2: Bool = false
    @State private var step3: Bool = false

    let dropZoneSize = CGSize(width: 150, height: 150)
    let cardSize = CGSize(width: 140, height: 150)
    
    var body: some View {
        GeometryReader { geometry in
            Color("game-view-bg")
            
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 700, height: 350)
                    .alignmentGuide(.leading) { d in
                        (geometry.size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (geometry.size.height - d.height) / 2
                    }
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    Image(systemName: "info.circle")
                        .padding(20)
                }
//                .background(.pink)
                .frame(width: 700)

                
                VStack {
                    HStack {
                        ZStack {
                            ForEach(cards.filter { $0.name != "Bomb"}, id: \.self) { card in
                                card.backImage
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .onTapGesture {
                                        withAnimation {
                                            addCard(card: pickCards[pickCards.count - 1], count: 1, to: &playerCards, remove: true, from: &pickCards)
                                        }
                                    }
                            }
                            
                            if step2 {
                                HStack(spacing: -10) {
                                    Text("Pick Your Card Here")
                                        .frame(width: 100)
                                    
                                    Image("step2")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(20))
                                }
                                .offset(x: -160)
                            }
                        }
                        .onChange(of: playerCards.count, initial: false, { oldCount, newCount in
                            if newCount != oldCount {
                                cardOffsets.append(.zero)
                                isDragging.append(false)
                                isCardInDropZone.append(false)
                                cardVisible.append(true)
                            }
                        })
                                  
                        ZStack(alignment: .top) {
                            DropZoneView(size: dropZoneSize, areAnyCardsInDropZone: isCardInDropZone.contains(true))
                            
                            if currentCard != nil {
                                currentCard?.frontImage
                                    .resizable()
                                    .frame(width: 150, height: 150)
                            }
                            
                            if step1 {
                                HStack(spacing: -10) {
                                    Image("step1")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(20))
                                    
                                    Text("Drop Your Card Here")
                                        .frame(width: 100)
                                }
                                .offset(x: 160)
                            }

                        }
                        .onChange(of: currentCard, initial: true) { newCard, oldCard in
                            if currentCard != nil {
                                withAnimation{
                                    step1 = false
                                    step2 = true
                                }
                            }
                            
                        }
                    }
                    
                    HStack(spacing: -50) {  // Spacing between the cards and drop zone
                        // Draggable Cards
                        ForEach(playerCards.indices, id: \.self) { index in
                            let card = playerCards[index]
                            if cardVisible[index] {
                                DragCard(
                                    cardSize: cardSize,
                                    dropZoneSize: dropZoneSize, card: card,
                                    isDragging: $isDragging[index],
                                    isCardInDropZone: $isCardInDropZone[index],
                                    cardOffset: $cardOffsets[index], currentCard: $currentCard,
                                    cardIndex: index,
                                    dropZoneFrame: geometry.frame(in: .global),
                                    cardVisible: $cardVisible[index]
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PlayCardTutorial()
}
