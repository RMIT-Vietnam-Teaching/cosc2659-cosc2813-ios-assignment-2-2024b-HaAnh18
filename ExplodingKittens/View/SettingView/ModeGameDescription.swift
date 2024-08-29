//
//  ModeGameDescription.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
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

struct ModeGameDescription: View {
    @State private var cardGame: [String: [Int]]?
    @EnvironmentObject var localizationManager: LocalizationManager

    var modeGame: ModeGame
    let orderedKeys = ["Bomb", "Defuse", "Attack", "See The Future", "Shuffle", "Skip", "Steal A Card"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TableView(cardGame: cardGame, orderedKeys: orderedKeys)
                
                Text("Description", manager: localizationManager)
                    .font(Font.custom("Quicksand-Bold", size: 24))

                
                Text(localizationManager.localizedString(for: modeGame.description))
                    .font(Font.custom("Quicksand-Regular", size: 20))
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 70)
        .padding(.horizontal, 30)
        .onAppear {
            cardGame = [
                "Bomb": modeGame.bomb,
                "Defuse": modeGame.defuse,
                "Attack": modeGame.attack,
                "See The Future": modeGame.seeFuture,
                "Shuffle": modeGame.shuffle,
                "Skip": modeGame.skip,
                "Steal A Card": modeGame.stealCard
            ]
        }
    }
}

#Preview {
//    ModeGameDescription(modeGame: modeGame[0])
    MenuView()

}





