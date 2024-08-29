//
//  PickStealCard.swift
//  ExplodingKittens
//
//  Created by Nana on 16/8/24.
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

struct PickStealCard: View {
    @EnvironmentObject var localizationManager: LocalizationManager

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
                    .frame(width: widthRecSize, height: heightRecSize)
                    .foregroundColor(Color("custom-white"))
                
                VStack(spacing: 20) {
                    Text("Pick a card to give", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 32))
                        .foregroundColor(Color("custom-black"))

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
                                            withAnimation {
                                                chosenCard = card
                                            }
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
                                Text("Confirm", manager: localizationManager)
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
            heightRecSize = 300
        case .medium:
            widthRecSize = 600
            heightRecSize = 300
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
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

//    GameView(numberOfPlayers: 4)
}


