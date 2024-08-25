//
//  ModeGameDescription.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
//

import SwiftUI

struct ModeGameDescription: View {
    @State private var cardGame: [String: [Int]]?
    var modeGame: ModeGame
    let orderedKeys = ["Bomb", "Defuse", "Attack", "See The Future", "Shuffle", "Skip", "Steal A Card"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TableView(cardGame: cardGame, orderedKeys: orderedKeys)
    //                .background(.pink)
                
                Text("Description")
                    .font(Font.custom("Quicksand-Bold", size: 24))
//                    .fontWeight(.semibold)

                
                Text(modeGame.description)
                    .font(Font.custom("Quicksand-Regular", size: 20))

            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 70)
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
    ModeGameDescription(modeGame: modeGame[0])

}





