//
//  Leaderboard.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//

import SwiftUI

struct Leaderboard: View {
//    @State private var players: [Player] = []
    @State private var players: [Player] = [
        Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 7, lose: 3, level: 10), // Level 10, Win rate 70%
        Player(name: "Alice", cards: cards, numberOfTurn: 1, index: 1, countinuePlay: true, win: 9, lose: 1, level: 1),
        Player(name: "Bob", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5)
       ]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Color("game-view-bg")
                    .ignoresSafeArea()
                
//                RoundedRectangle(cornerRadius: 25.0)
//                    .frame(width: size.width / 2 + 300)
//                    .position(x: size.width / 2, y: size.height / 2)
//                    .foregroundColor(.white)
////                    .background(.pink)
//                    .padding(.vertical, 20)
//                
//
                VStack {
                    Text("Leaderboard")
                    
                }
                
    //            List {
    //                Section(header: Text("List Of HigheScores")
    //                    .textCase(.uppercase)
    //                    .padding(.top))
    //                     {
    //                         ForEach(players.sorted(by: {
    //                             if $0.level == $1.level {
    //                                 return $0.winRate > $1.winRate
    //                             } else {
    //                                 return $0.level > $1.level
    //                             }
    //                         }), id: \.name) { player in
    //                             HStack {
    //                                 Text(player.name)
    //                                 Spacer()
    //                                 Text("Wins: \(player.win)")
    //                                 Spacer()
    //                                 Text("Loses: \(player.lose)")
    //                                 Spacer()
    //                                 Text("Win Rate: \(String(format: "%.0f", player.winRate))%")
    //                                 Spacer()
    //                                 Text("Level: \(player.level)")
    //                             }
    //                             .padding()
    //                         }
    //                    }
    //
    //            }
            }
        }
        .onAppear {
//            players = getPlayers()
        }
    }
}

#Preview {
    Leaderboard()
}
