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
    @State private var selectedPlayer: Player? = nil
    @State private var dragLocation: CGPoint = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
            
            VStack(spacing: 10) {
                Text("No. games each player")
                    .font(Font.custom("Quicksand-Medium", size: 20))
                
                GeometryReader { geometry in
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
                    .padding()
                    .overlay(
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        dragLocation = value.location
                                        selectedPlayer = findPlayer(at: value.location, in: geometry.size)
                                    }
                                    .onEnded { _ in
                                        selectedPlayer = nil
                                    }
                            )
                    )
                    
                    if let selectedPlayer = selectedPlayer {
                        let barWidth = (geometry.size.width / CGFloat(players.count))
                        let index = players.firstIndex(of: selectedPlayer) ?? 0
                        let xPosition = CGFloat(index) * barWidth + barWidth / 2
                        
                        VStack {
                            HStack {
                                Text("Player:")
                                    .font(Font.custom("Quicksand-Bold", size: 16))

                                
                                Text(selectedPlayer.name)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Level:")
                                    .font(Font.custom("Quicksand-Bold", size: 16))

                                
                                Text("\(selectedPlayer.level)")
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Win:")
                                    .font(Font.custom("Quicksand-Bold", size: 16))

                                
                                Text("\(selectedPlayer.win)")
                                    .font(Font.custom("Quicksand-Regular", size: 16))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Losses:")
                                    .font(Font.custom("Quicksand-Bold", size: 16))

                                
                                Text("\(selectedPlayer.lose)")
                                    .font(Font.custom("Quicksand-Regular", size: 16))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Win Rate:")
                                    .font(Font.custom("Quicksand-Bold", size: 16))

                                
                                Text("\(String(format: "%.0f", selectedPlayer.winRate)) %")
                                    .font(Font.custom("Quicksand-Regular", size: 16))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        }
//                                .padding(8)
                        .frame(width: 160)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .position(x: xPosition, y: dragLocation.y - 50) // Adjust y-offset as needed
                    }
                    
                }
                
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
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

        }
    }
    
    func findPlayer(at location: CGPoint, in size: CGSize) -> Player? {
        // Assuming the chart is divided equally for each player
        let barWidth = size.width / CGFloat(players.count)
        let index = Int(location.x / barWidth)
        if index >= 0 && index < players.count {
            return players[index]
        }
        return nil
    }
}

#Preview {
//    LineChart()
    Leaderboard()
}
