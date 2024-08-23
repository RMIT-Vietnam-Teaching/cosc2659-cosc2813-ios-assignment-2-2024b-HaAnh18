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
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    Color("game-view-bg")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 10) {
                        Text("Exploding Kittens")
                            .font(Font.custom("Quicksand-Bold", size: 40))
                        
                        HStack(spacing: -50) {
                            Image("exploding-kitten")
                                .resizable()
                                .frame(width: 250, height: 250)
                            
                            VStack(alignment: .leading) {
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
                                    
                                    NavigationLink(destination: PlayCardTutorial()) {
                                        Text("Tutorial")
                                            .modifier(buttonCapsule())
                                    }
                                    
                                }
                            }
                            .frame(width: size.width / 2)
//                            .background(.yellow)
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


