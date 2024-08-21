//
//  MenuView.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Color("game-view-bg")
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 20) {
                    Button("New Game") {
                        
                    }
                        .modifier(buttonCapsule())
                    
                    Button("Leaderboard") {
                        
                    }
                        .modifier(buttonCapsule())
                    
                    Button("How To Play") {
                        
                    }
                        .modifier(buttonCapsule())
                    
                    
                    Button("Settings") {
                        
                    }
                        .modifier(buttonCapsule())
                    
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
