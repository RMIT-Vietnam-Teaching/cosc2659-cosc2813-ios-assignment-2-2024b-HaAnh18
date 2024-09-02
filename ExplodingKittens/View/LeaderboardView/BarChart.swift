//
//  BarChart.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
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
import Charts

struct BarChart: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var players: [Player]
    @State private var selectedPlayer: Player? = nil
    @State private var dragLocation: CGPoint = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("player-row"))
            
            VStack(spacing: 10) {
                Text("Top 5 highest players", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 20))
                    .foregroundColor(.black)
                
                VStack {
                    GeometryReader { geometry in
                        Chart {
                            // Loop through the top 5 players and create a BarMark for each.
                            ForEach(players.prefix(5), id: \.self) { player in
                                BarMark(x: .value(localizationManager.localizedString(for: "Player"), player.name),
                                        y: .value(localizationManager.localizedString(for:"Win Rate"), player.winRate))
                            }
                        }
                        .foregroundColor(Color("lightblue"))
                        .chartXAxis {
                            AxisMarks { _ in
                                AxisValueLabel()
                                    .foregroundStyle(.black) // Set color for the player names (x-axis labels)
                                AxisGridLine()
                                    .foregroundStyle(Color("chart-line")) // Set color for the x-axis grid lines
                            }
                        }
                        .chartYAxis {
                            AxisMarks { _ in
                                AxisValueLabel() // Ensure y-axis labels are shown
                                    .foregroundStyle(.black) // Optional: Set color for y-axis labels
                                AxisGridLine()
                                    .foregroundStyle(Color("chart-line")) // Set color for the y-axis grid lines
                            }
                        }
                        .overlay(
                            // Add an invisible overlay to detect drag gestures.
                            Color.clear
                                .contentShape(Rectangle()) // Defines the area that is sensitive to gestures.
                                .gesture(
                                    // Add a drag gesture to detect touch and drag interactions.
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { value in
                                            // When the user drags, update the drag location and find the corresponding player.
                                            dragLocation = value.location
                                            selectedPlayer = findPlayer(at: value.location, in: geometry.size)
                                        }
                                        .onEnded { _ in
                                            // When the drag ends, clear the selected player.
                                            selectedPlayer = nil
                                        }
                                )
                        )
                                    
                        if let selectedPlayer = selectedPlayer {
                            // Calculate the width of each bar in the chart.
                            let barWidth = (geometry.size.width / CGFloat(players.count))
                            
                            // Find the index of the selected player in the players array.
                            let index = players.firstIndex(of: selectedPlayer) ?? 0
                            
                            // Calculate the x position of the tooltip based on the player's index.
                            let xPosition = CGFloat(index) * barWidth + barWidth / 2
                            
                            VStack {
                                HStack {
                                    Text("Player:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))
                                        .foregroundColor(.black)

                                    
                                    Text(selectedPlayer.name)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Level:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))
                                        .foregroundColor(.black)

                                    
                                    Text("\(selectedPlayer.level)")
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Wins:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))
                                        .foregroundColor(.black)

                                    Text("\(selectedPlayer.win)")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Losses:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))
                                        .foregroundColor(.black)

                                    
                                    Text("\(selectedPlayer.lose)")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                
                                HStack {
                                    Text("Win Rate:", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 16))
                                        .foregroundColor(.black)

                                    
                                    Text("\(String(format: "%.0f", selectedPlayer.winRate)) %")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                            }
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
        // Calculate the width of each bar in the chart based on the total width and the number of players.
        let barWidth = size.width / CGFloat(players.count)
        
        // Determine the index of the player by dividing the x-coordinate of the touch location by the bar width.
        let index = Int(location.x / barWidth)
        
        // Check if the calculated index is within the valid range of the players array.
        if index >= 0 && index < players.count {
            // If the index is valid, return the corresponding player.
            return players[index]
        }
        
        // If the index is out of bounds, return nil.
        return nil
    }
}

#Preview {
//    BarChart()
    Leaderboard()
        .environmentObject(LocalizationManager())
}
