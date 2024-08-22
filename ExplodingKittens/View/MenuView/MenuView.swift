//
//  MenuView.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
//

import SwiftUI

struct MenuView: View {
    @State private var isGameDataAvailable: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("game-view-bg")
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        if isGameDataAvailable {
                            NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, resumeGame: true)) {
                                Text("Resume Game")
                                    .modifier(buttonCapsule())
                            }
                        }
                        
                        NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, resumeGame: false)) {
                            Text("New Game")
                                .modifier(buttonCapsule())
                        }
                        
                        NavigationLink(destination: Leaderboard()) {
                            Text("Leaderboard")
                                .modifier(buttonCapsule())
                        }

                    }
                }
                
            }
            .onAppear {
                isGameDataAvailable = UserDefaults.standard.data(forKey: "gameData") != nil
            }
        }
    }
}

#Preview {
    MenuView()
}
