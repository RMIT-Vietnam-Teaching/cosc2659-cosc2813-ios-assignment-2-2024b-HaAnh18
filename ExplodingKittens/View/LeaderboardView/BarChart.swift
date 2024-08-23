//
//  BarChart.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//

import SwiftUI
import Charts

struct BarChart: View {
//    @State private var players: [Player] = [
//        Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 7, lose: 3, level: 10), // Level 10, Win rate 70%
//        Player(name: "Alice", cards: cards, numberOfTurn: 1, index: 1, countinuePlay: true, win: 9, lose: 1, level: 1),
//        Player(name: "Bob", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5),
//        Player(name: "A", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5),
//        Player(name: "B", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5)
//       ]
    
    @Binding var players: [Player]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
            
            VStack(spacing: 10) {
                Text("Top 5 highest players")
                    .font(Font.custom("Quicksand-Medium", size: 20))
                
                Chart {
                    ForEach(players.prefix(5), id: \.self) { player in
                        BarMark(x: .value("Player", player.name),
                                y: .value("Win Rate", player.winRate))
                    }
                }
                .foregroundColor(Color("lightblue"))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

        }
        .frame(height: 200)
    }
}

#Preview {
//    BarChart()
    Leaderboard()
}
