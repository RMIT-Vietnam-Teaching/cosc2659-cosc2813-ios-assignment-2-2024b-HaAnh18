//
//  DropDestination.swift
//  ExplodingKittens
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

struct DropDestination: View {
    @EnvironmentObject var localizationManager: LocalizationManager
 
    @Binding var droppedCards: [Card]
    var screenSize: ScreenSizeCategory
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                .frame(width: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220, height: screenSize == .small ? 150 : screenSize == .medium ? 160 : 220)
            
            if droppedCards.count == 0 {
                Text("Drop Your Card Here", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 24))
                    .frame(width: screenSize == .small ? 140 : screenSize == .medium ? 150 : 210)
                    .multilineTextAlignment(.center)
            }
            
            ForEach(droppedCards.indices, id: \.self) { index in
                let card = droppedCards[index]
                card.frontImage
                    .resizable()
                    .rotationEffect(.degrees(index % 2 == 0 ? Double(index) * 1 : Double(index) * -1))
                    .frame(width: screenSize == .small ? 140 : screenSize == .medium ? 150 : 210, height: screenSize == .small ? 140 : screenSize == .medium ? 150 : 210)
                    .scaledToFit()
            }
//            .frame(width: 160, height: 160)
            
        }
    }
 
}

#Preview {
//    DropDestination()
    MenuView()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

//    GameView(numberOfPlayers: 4)
}
