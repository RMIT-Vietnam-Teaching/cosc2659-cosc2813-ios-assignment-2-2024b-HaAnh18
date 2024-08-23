//
//  LineChart.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    @Binding var players: [Player]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
            
            VStack(spacing: 10) {
                Text("No. games each player")
                    .font(Font.custom("Quicksand-Medium", size: 20))
                
                Chart() {
                    ForEach(players, id: \.self) { player in
                        // Line for Wins
                        LineMark(
                            x: .value("Player", player.name),
                            y: .value("Wins", player.win),
                            series: .value("", "Wins")
                        )
                        .foregroundStyle(Color.green)
                        .symbol(Circle())
                        
                        
                        // Line for Losses
                        LineMark(
                            x: .value("Player", player.name),
                            y: .value("Losses", player.lose),
                            series: .value("", "Lose")
                        )
                        .foregroundStyle(Color.red)
                        .symbol(Circle())
                        
                    }
                }
                .chartXAxisLabel("Player")
                .chartYAxisLabel("Number of Games")
                .frame(height: 300)
                .padding()
                
                HStack {
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                        Text("Wins")
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Losses")
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 10)
                  
            }
//            .frame(width: 200, height: 100)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

        }
//        .frame(height: 300)
//        .frame(width: 300, height: 300)
//        .frame(width: 400, height: 400)
    }
}

#Preview {
//    LineChart()
    Leaderboard()
}
