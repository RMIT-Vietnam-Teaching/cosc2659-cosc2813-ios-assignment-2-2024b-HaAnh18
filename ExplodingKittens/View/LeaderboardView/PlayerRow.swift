//
//  PlayerRow.swift
//  ExplodingKittens
//
//  Created by Nana on 22/8/24.
//

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
//                .frame(width: 200)
//                .stroke(Color("game-view-bg"), lineWidth: 10.0)
                .foregroundColor(.white)
            
            HStack {
//                HStack(spacing: 10) {
                if index < 3 {
                    Image(index == 0 ?"first" : index == 1 ? "second" : "third")
                            .resizable()
                            .frame(width: 80, height: 80)
        //                    .background(.pink)
                            .padding(0)
                } else {
                    Text("\(index + 1)")
                        .font(Font.custom("Quicksand-Regular", size: 36))
                        .frame(width: 80, height: 80)
                }
                
                    
//                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(player.name)
                            .font(Font.custom("Quicksand-Medium", size: 36))
                        
                        HStack {
                            Text("Win: \(player.win)")
                                .font(Font.custom("Quicksand-Regular", size: 16))
                                .fontWeight(.light)
                            
                            Text("Lose: \(player.lose)")
                                .font(Font.custom("Quicksand-Regular", size: 16))
                                .fontWeight(.light)
                        }
                }
                
                Spacer()
                
                Loader(percent: player.winRate)
                    .padding(.horizontal, 10)
                
            }
//            .background(.pink)
            .padding(.horizontal, 20)
            
        }
        .frame(height: 120)
    }
}

#Preview {
    PlayerRow(player: Player(name: "John", cards: cards, numberOfTurn: 1, index: 0, countinuePlay: true, win: 7, lose: 3, level: 10), index: 5)
}
