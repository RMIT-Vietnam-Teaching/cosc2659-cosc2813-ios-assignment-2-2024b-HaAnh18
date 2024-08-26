//
//  TutorialView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//


import SwiftUI

struct PlayCardTutorial: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var cardOffsets: [CGSize] = Array(repeating: .zero, count: cards.count) // For two cards
    @State private var isDragging = Array(repeating: false, count: cards.count)
    @State private var isCardInDropZone = Array(repeating: false, count: cards.count) // Track if each card is in the drop zone
    @State private var cardVisible = Array(repeating: true, count: cards.count) // Track visibility of each card
    @State private var currentCard: Card?
    @State private var showingSheet: Bool = false
    @State private var pickCards: [Card] = cards.filter {$0.name != "Bomb"}
    @State private var playerCards: [Card] = cards.filter {$0.name != "Bomb"}
    @State private var step1: Bool = false
    @State private var step2: Bool = false
    @State private var step3: Bool = false
    @State private var dragCardSize: CGFloat = 10
    @State private var pickCardSize: CGFloat = 10
    @State private var dropZone: CGFloat = 10
    @State private var yourTurn: Bool = true
    
    let dropZoneSize = CGSize(width: 150, height: 150)
    let cardSize = CGSize(width: 140, height: 150)
    
    var body: some View {
        GeometryReader { geometry in
            let sizeCategory = getScreenSizeCategory(for: geometry.size)
            Color("game-view-bg")
            
            
            ZStack(alignment: .top) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()

                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)

                        Text("Menu", manager: localizationManager)
                            .font(Font.custom("Quicksand-Regular", size: 24))
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                }
                .frame(height: 50)
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                
                HStack {
                    Spacer()
                    VStack(spacing: -20) {
                        Spacer()
                        if step3 {
                            VStack(spacing: -20) {
                                Text("Click For Card Description", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Regular", size: 20))
                                    .frame(width: 130)
                                Image("step3")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }

                        
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                                .padding(20)
                                .foregroundColor(.black)
                        })
                        .sheet(isPresented: $showingSheet) {
                            TabViewCardDescription( showingSheet: $showingSheet)
                                .presentationDetents([.medium, .medium, .fraction(0.1)])
                        }
                    }
                    
                }
                .padding(10)

                
                VStack(spacing: 0) {
                    CardList(cards: Array(cards.prefix(5)), position: "top", screenSize: sizeCategory)
                        .frame(height: geometry.size.height / 3 - 50)
                    HStack {
                        ZStack {
                            if !pickCards.isEmpty {
                                ForEach(cards.filter { $0.name != "Bomb"}, id: \.self) { card in
                                    card.backImage
                                        .resizable()
                                        .frame(width: sizeCategory == .medium ? 150 : 220, height: sizeCategory == .medium ? 150 : 220)
                                        .onTapGesture {
                                            if yourTurn {
                                                withAnimation {
                                                    addCard(card: pickCards[pickCards.count - 1], count: 1, to: &playerCards, remove: true, from: &pickCards)
                                                    yourTurn = false
                                                    step2 = false
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        withAnimation {
                                                            step3 = true
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                            
                            if step2 {
                                HStack(spacing: -10) {
                                    Text("Pick Your Card Here", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Regular", size: 20))
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
                            DropZoneView(screenSize: sizeCategory)
                            
                            if currentCard != nil {
                                currentCard?.frontImage
                                    .resizable()
                                    .frame(width: sizeCategory == .medium ? 150 : 200, height: sizeCategory == .medium ? 150 : 200)
                            }
                            
                            if step1 {
                                HStack(spacing: -10) {
                                    Image("step1")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(20))
                                    
                                    Text("Drop Your Card Here", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Regular", size: 20))
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
                    .frame(height: geometry.size.height / 3 + 50)
                    
                    Spacer()
                    
                    HStack(spacing: -70) {  // Spacing between the cards and drop zone
                        // Draggable Cards
                        ForEach(playerCards.indices, id: \.self) { index in
                            let card = playerCards[index]
                            if cardVisible[index] {
                                DragCard(
                                    dropZoneSize: dropZoneSize, card: card,
                                    isDragging: $isDragging[index],
                                    isCardInDropZone: $isCardInDropZone[index],
                                    cardOffset: $cardOffsets[index], currentCard: $currentCard,
                                    cardIndex: index,
                                    dropZoneFrame: geometry.frame(in: .global),
                                    cardVisible: $cardVisible[index], screenSize: sizeCategory
                                )
                            }
                        }
                    }
                    
                    .frame(height: geometry.size.height / 3)
//                    .padding(.bottom, 40)
                    
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation{
                    step1 = true
                }
            }
        }

    }
}

#Preview {
    PlayCardTutorial()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
