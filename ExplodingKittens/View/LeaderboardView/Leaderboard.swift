//
//  Leaderboard.swift
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

struct Leaderboard: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var localizationManager: LocalizationManager
    
    @State private var players: [Player] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Color("game-view-bg")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        HStack {
                            // A button that dismisses the current view and returns to the previous screen.
                            Button(action: {
                                // Dismiss the current view by accessing the wrapped value of the presentation mode.
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color("custom-black"))

                                Text("Menu", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Regular", size: 24))
                                    .foregroundColor(Color("custom-black"))
                            })
                            
                            Spacer()
                        }
                        .frame(height: 30)
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 10) {
                                Text("Leaderboard", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Bold", size: 32))
                                    .foregroundColor(Color("custom-black"))
               
                                ForEach(players.indices, id: \.self) {
                                    index in
                                    
                                    PlayerRow(player: players[index], index: index)
                                }
                                Spacer()
                            }
                            .frame(width: size.width / 2)
                            
                            
                            ZStack(alignment: .top) {
                                VStack(spacing: 10) {
                                    Text("Statistics", manager: localizationManager)
                                        .font(Font.custom("Quicksand-Bold", size: 32))
                                        .foregroundColor(Color("custom-black"))
                                    
                                    if !players.isEmpty {
                                        BarChart(players: $players)
                                    }
                                    Spacer()
                                    
                                    if !players.isEmpty {
                                        LineChart(players: $players)
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            // When the view appears, fetch and set the players.
            players = getPlayers()
            
            // Sort the players using the `sortPlayers` function and update the `players` array.
            players = sortPlayers(players)
        }
        .navigationBarBackButtonHidden(true) // Hide the default navigation bar back button.
    }
    
}

#Preview {
    Leaderboard()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//    MenuView()
}
