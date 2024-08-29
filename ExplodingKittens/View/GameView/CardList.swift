//
//  CardList.swift
//  ExplodingKitten
//
//  Created by Nana on 11/8/24.
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

struct CardList: View {
    var cards: [Card]
    var position: String
    var screenSize: ScreenSizeCategory
//    @State private var cardSize: CGFloat? = nil
    
    var body: some View {
        
        if position == "top" {
            HStack(spacing: -60) {
                ForEach(cards, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: screenSize == .medium ? 110 : screenSize == .small ? 90 : 180 , height: screenSize == .medium ? 110 : screenSize == .small ? 90 : 180)
                        .scaledToFit()
                        .rotationEffect(.degrees(180))
                }
                .padding(.vertical, -7)
            }
            .offset(y: -10)
        } else {
            VStack(spacing: -70) {
                ForEach(cards, id: \.self) { card in
                    card.backImage
                        .resizable()
                        .frame(width: screenSize == .medium ? 110 : screenSize == .small ? 90 : 180, height: screenSize == .medium ? 110 : screenSize == .small ? 90 : 180)
                        .scaledToFit()
                        .rotationEffect(.degrees(position == "left" ? 90 : -90))
                }
            }
            .frame(width: position == "top" ? 300 : 80, height: position == "top" ? 80 : 200)
            .padding(0)
        }
    }
}

#Preview {
//    MenuView()
    CardList(cards: cards, position: "top", screenSize: .large)
//    GameView(numberOfPlayers: 4)
}
