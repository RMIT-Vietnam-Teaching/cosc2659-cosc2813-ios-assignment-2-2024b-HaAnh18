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
    
//    @State private var players: [Player] = []
    @State private var players: [Player] = [
        Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 7, lose: 3, level: 10), // Level 10, Win rate 70%
        Player(name: "Alice", cards: cards, numberOfTurn: 1, index: 1, countinuePlay: true, win: 9, lose: 1, level: 1),
        Player(name: "Bob", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5),
        Player(name: "A", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 0, level: 5),
        Player(name: "B", cards: cards, numberOfTurn: 1, index: 2, countinuePlay: true, win: 5, lose: 5, level: 5)
       ]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Color("game-view-bg")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()

                            }, label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)

                                Text("Menu", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Regular", size: 24))
                                    .foregroundColor(.black)
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
//            players = getPlayers()
            players = sortPlayers(players)
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    Leaderboard()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//    MenuView()
}
