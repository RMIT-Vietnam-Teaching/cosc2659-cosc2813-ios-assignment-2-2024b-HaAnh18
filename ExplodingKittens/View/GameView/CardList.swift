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
    
    var body: some View {
        if position == "top" {
            HStack(spacing: cards.count < 10 ? -70 : -100) {
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
            VStack(spacing: cards.count < 6 ? -70 : -80) {
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
    CardList(cards: cards, position: "right", screenSize: .small)
//    GameView(numberOfPlayers: 4)
}
