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
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var players: [Player]
    @State private var selectedPlayer: Player? = nil
    @State private var dragLocation: CGPoint = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
            
            VStack(spacing: 10) {
                Text("Top 5 highest players", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 20))
                
                VStack {
                    GeometryReader { geometry in
                        Chart {
                            ForEach(players.prefix(5), id: \.self) { player in
                                BarMark(x: .value(localizationManager.localizedString(for: "Player"), player.name),
                                        y: .value(localizationManager.localizedString(for:"Win Rate"), player.winRate))
                            }
                        }
                        .foregroundColor(Color("lightblue"))
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
                                    Text("Player:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))

                                    
                                    Text(selectedPlayer.name)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Level:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))

                                    
                                    Text("\(selectedPlayer.level)")
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Wins:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))

                                    
                                    Text("\(selectedPlayer.win)")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Losses:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))

                                    
                                    Text("\(selectedPlayer.lose)")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Win Rate:", manager: localizationManager)
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
                }
                
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .frame(height: 300)
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
//    BarChart()
    Leaderboard()
        .environmentObject(LocalizationManager())
}
