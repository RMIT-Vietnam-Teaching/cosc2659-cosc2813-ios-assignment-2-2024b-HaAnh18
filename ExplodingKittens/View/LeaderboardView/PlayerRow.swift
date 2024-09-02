//
//  PlayerRow.swift
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

struct PlayerRow: View {
    @State private var isAppear = true
    var player: Player
    var index: Int
    var percent: CGFloat = 70
    var colors: [Color] = [.red, .orange, .yellow, .green, .purple, .red]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("player-row"))
            
            HStack {
                // If the index is less than 3 (0, 1, or 2), display a corresponding top image.
                if index < 3 {
                    Image(index == 0 ?"top1" : index == 1 ? "top2" : "top3")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(0)
                } else {
                    // If the index is 3 or greater, display the index number as text.
                    Text("\(index + 1)")
                        .font(Font.custom("Quicksand-Regular", size: 36))
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                }
                
                    
                VStack(alignment: .leading, spacing: 10) {
                    Text(player.name)
                        .font(Font.custom("Quicksand-Medium", size: 30))
                        .foregroundColor(.black)
                    
                    HStack {
                        Text("Level:")
                            .font(Font.custom("Quicksand-Medium", size: 18))
                            .foregroundColor(.black)
                        
                        Text("\(player.level)")
                            .font(Font.custom("Quicksand-Regular", size: 18))
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        ForEach(Array(player.archivement.keys), id: \.self) { key in
                            Badge(color: player.archivement[key]![0], content: key, image: player.archivement[key]![1])
                        }
                    }
                }
                
                Spacer()
                
                Loader(percent: player.winRate)
                    .padding(.horizontal, 10)
                
            }
            .padding(.horizontal, 20)
            
        }
        .frame(height: 150)
    }
}

#Preview {
    PlayerRow(player: Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 7, lose: 0, level: 10), index: 5)
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
