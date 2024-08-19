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
        ZStack {
            
//            Color(.pink.opacity(0.2))
//                .ignoresSafeArea()
            
            GifImage(name: "bomb")
                .aspectRatio(contentMode: .fill)
                .overlay(.pink.opacity(0.2))
//                .frame(width: )
           
            VStack(spacing: 30) {
//                ZStack {
//                    GifImage(name: "bomb")
//                        .aspectRatio(contentMode: .fit)
//                        .overlay(.pink.opacity(0.2))
//                    
                    Text("Gameover")
//                }
//                
//                Spacer()
                Text("Return")
                    .modifier(buttonCapsule())
//                
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
    GameOverView()
}
