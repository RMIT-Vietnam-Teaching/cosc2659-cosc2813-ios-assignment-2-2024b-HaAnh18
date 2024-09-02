//
//  LineChart.swift
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

struct LineChart: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var players: [Player]
    @State private var selectedPlayer: Player? = nil
    @State private var dragLocation: CGPoint = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("player-row"))
            
            VStack(spacing: 10) {
                Text("No. games each player", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 20))
                    .foregroundColor(.black)
                
                GeometryReader { geometry in
                    Chart() {
                        // Iterate through each player to plot their wins and losses.
                        ForEach(players, id: \.self) { player in
                            // Line for Wins
                            LineMark(
                                x: .value("Player", player.name), // X-axis represents the player's name.
                                y: .value("Wins", player.win), // Y-axis represents the number of wins.
                                series: .value("", "Wins") // Series label for the wins line.
                            )
                            .foregroundStyle(.green) // Set the line color to green for wins.
                            .symbol(Circle()) // Use a circle symbol for the points on the line.
                            
                            // Line for Losses
                            LineMark(
                                x: .value("Player", player.name), // X-axis represents the player's name.
                                y: .value("Losses", player.lose), // Y-axis represents the number of losses.
                                series: .value("", "Lose") // Series label for the losses line.
                            )
                            .foregroundStyle(.red) // Set the line color to red for losses.
                            .symbol(Circle()) // Use a circle symbol for the points on the line.
                            
                        }
                    }
                    .chartXAxis {
                        AxisMarks { _ in
                            AxisValueLabel() // This sets the label for the x-axis (player names)
                                .foregroundStyle(.black) // Set the color of the player names
                            AxisGridLine() // This sets the grid line for the x-axis
                                .foregroundStyle(Color("chart-line")) // Set the color of the x-axis grid lines
                        }
                    }
                    .chartYAxis {
                        AxisMarks { _ in
                            AxisValueLabel() // This sets the label for the y-axis (numbers on the y-axis)
                                .foregroundStyle(.black) // Optional: Set the color of the y-axis labels
                            AxisGridLine() // This sets the grid line for the y-axis
                                .foregroundStyle(Color("chart-line")) // Set the color of the y-axis grid lines
                        }
                    }
                    .chartXAxisLabel {
                        Text(localizationManager.localizedString(for: "Player"))
                            .foregroundStyle(.black) // Set the color for the X-axis label
                    }
                    .chartYAxisLabel {
                        Text(localizationManager.localizedString(for: "Number of Games"))
                            .foregroundStyle(.black) // Set the color for the Y-axis label
                    }
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
                                Text("Player:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Bold", size: 16))
                                    .foregroundColor(.black)

                                
                                Text(selectedPlayer.name)
                                    .font(Font.custom("Quicksand-Regular", size: 16))
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            
                            HStack {
                                Text("Level:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Bold", size: 16))
                                    .foregroundColor(.black)

                                
                                Text("\(selectedPlayer.level)")
                                    .font(Font.custom("Quicksand-Regular", size: 16))
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
                
                HStack {
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                        Text("Wins", manager: localizationManager)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Losses", manager: localizationManager)
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 10)
                  
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(minHeight: 300)
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
        .environmentObject(LocalizationManager())

}
