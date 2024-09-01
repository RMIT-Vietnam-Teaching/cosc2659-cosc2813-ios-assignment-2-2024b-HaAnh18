//
//  TutorialView.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Nguyen Tran Ha Anh
  ID: s3938490
  Created  date: 06/08/2024
  Last modified: 03/09/2024
  Acknowledgement:
*/

import SwiftUI

struct PlayCardTutorial: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var theme: String

    @State private var cardOffsets: [CGSize] = Array(repeating: .zero, count: cards.count)
    @State private var cardVisible = Array(repeating: true, count: cards.count)
    @State private var currentCard: Card?
    @State private var showingSheet: Bool = false
    @State private var pickCards: [Card] = []
    @State private var playerCards: [Card] = []
    @State private var step1: Bool = false
    @State private var step2: Bool = false
    @State private var step3: Bool = false
    @State private var step4: Bool = false
    @State private var yourTurn: Bool = true
    @State private var percentBomb: CGFloat = 0
        
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
                            .foregroundColor(Color("custom-black"))

                        Text("Menu", manager: localizationManager)
                            .font(Font.custom("Quicksand-Regular", size: 24))
                            .foregroundColor(Color("custom-black"))
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
                                    .foregroundColor(Color("custom-black"))
                                    .frame(width: 130)
                                Image("step3")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color("custom-black"))
                            }
                        }

                        
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                                .padding(20)
                                .font(.system(size: 24))
                                .foregroundColor(Color("custom-black"))
                        })
                        .sheet(isPresented: $showingSheet) {
                            TabViewCardDescription( showingSheet: $showingSheet, theme: $theme)
                                .presentationDetents([.medium, .medium, .fraction(0.1)])
                        }
                    }
                    
                }
                .padding(10)

                
                VStack(spacing: 0) {
                    CardList(cards: Array(pickCards.prefix(5)), position: "top", screenSize: sizeCategory)
                        .frame(height: geometry.size.height / 3 - 50)
                    HStack {
                        ZStack {
                            BombPercent(percent: $percentBomb)
                                .onChange(of: pickCards.count, initial: true) {
                                    percentBomb = calculateBombPercent(cards: pickCards)
                                }
                            if step4 {
                                HStack(spacing: -40) {
                                    Text("Chance Of Bomb", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Regular", size: 20))
                                        .frame(width: 100)
                                        .foregroundColor(Color("custom-black"))
                                    
                                    Image("step4")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(20))
                                    
                                }
                                .frame(width: 80)
                                .offset(x: -105)
                            }
                        }
                        
                        VStack {
                            ZStack {
                                if !pickCards.isEmpty {
                                    ForEach(pickCards, id: \.self) { card in
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
                                                                step4 = true
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
                                            .foregroundColor(Color("custom-black"))
                                        
                                        Image("step2")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .rotationEffect(.degrees(20))
                                            .foregroundColor((Color("custom-black")))
                                    }
                                    .offset(x: -160, y: -70)
                                }
                            }
                            .onChange(of: playerCards.count, initial: false, { oldCount, newCount in
                                if newCount != oldCount {
                                    cardOffsets.append(.zero)
                                    cardVisible.append(true)
                                }
                            })
                            
                            Text("\(pickCards.count) cards left")
                                .font(Font.custom("Quicksand-Regular", size: 16))
                        }
                                  
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
                                        .foregroundColor(Color("custom-black"))
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
                                    card: card, dropZoneFrame: geometry.frame(in: .global),
                                    cardOffset: $cardOffsets[index], currentCard: $currentCard,
                                    cardVisible: $cardVisible[index], screenSize: sizeCategory
                                )
                            }
                        }
                    }
                    .frame(height: geometry.size.height / 3)
                    
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            pickCards = theme == "Rabbit" ? cardsV2 : cards
            prepareCards()
            playerCards = theme == "Rabbit" ? cardsV2.filter {$0.name != "Bomb"} : cards.filter {$0.name != "Bomb"}
            percentBomb = calculateBombPercent(cards: pickCards)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation{
                    step1 = true
                }
            }
            
        }

    }
    
    private func prepareCards() {
        let bombCards = pickCards.filter { $0.name == "Bomb" } // Step 1: Filter out "Bomb" cards
        pickCards.removeAll { $0.name == "Bomb" } // Step 2: Remove "Bomb" cards from the original array
        pickCards.insert(bombCards[0], at: 0)
    }
}

#Preview {
    PlayCardTutorial(theme: .constant("Rabbit"))
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
