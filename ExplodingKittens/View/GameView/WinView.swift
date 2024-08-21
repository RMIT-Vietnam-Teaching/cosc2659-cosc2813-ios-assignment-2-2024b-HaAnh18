//
//  WinView.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//

import SwiftUI

struct WinView: View {
    @State private var isVisible = false
    var body: some View {
        GeometryReader {
            let size = $0.size
//            Color(.blue)
//                .ignoresSafeArea()
            
            ZStack {
                GifImage(name: "win")
                    .ignoresSafeArea()
    //                .frame(height: 300)
                    .frame(width: size.width, height: size.height)
                    .aspectRatio(contentMode: .fill)
                    .overlay(.pink.opacity(0.2))
                

                    VStack {
                        Text("Winning")
                        
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
//    }
//    }
}

#Preview {
//    WinView()
    GameView(numberOfPlayers: 2)
}
