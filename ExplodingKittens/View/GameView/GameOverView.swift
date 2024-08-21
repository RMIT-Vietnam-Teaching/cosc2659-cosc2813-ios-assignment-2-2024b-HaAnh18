//
//  GameOverView.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//

import SwiftUI

struct GameOverView: View {
    @State private var isVisible = false

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                
                GifImage(name: "bomb")
                    .ignoresSafeArea()
    //                .frame(height: 300)
                    .frame(width: size.width, height: size.height)
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color("game-view-bg").opacity(0.5))
               
                VStack(spacing: 30) {
  
                        Text("Gameover")
 
                    Text("Return")
                        .modifier(buttonCapsule())
                }
            }
        }
        .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                isVisible = true
            }
        }
    }
}

#Preview {
//    GameOverView()
    GameView(numberOfPlayers: 2)
}
