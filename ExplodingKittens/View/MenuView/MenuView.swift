//
//  MenuView.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
//

import SwiftUI

struct MenuView: View {
    @State private var isGameDataAvailable: Bool = false
    @State private var language: String = "English"
    @State private var appearanceMode: AppearanceMode = .light
    @State private var colorScheme: ColorScheme?
    @State private var appearance: String = "Light"
    @State private var modeGame: String = "Medium"

    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    Color("game-view-bg")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Exploding Kittens")
                            .font(Font.custom("Quicksand-Bold", size: 40))
                        
                        HStack(spacing: 0) {
                            Image("exploding-kitten")
                                .resizable()
                                .frame(width: 250, height: 250)
                            
                            VStack(alignment: .leading) {
                                VStack(spacing: 10) {
                                    if isGameDataAvailable {
                                        NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, resumeGame: true)) {
                                            Text("Resume Game")
                                                .modifier(buttonCapsule())
                                        }
                                    }
                                    
                                    NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, resumeGame: false)) {
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
                                    
                                    NavigationLink(destination: Settings(modeGame: $modeGame, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance)) {
                                        Text("Settings")
                                            .modifier(buttonCapsule())
                                    }
                                    
                                }
                            }
                            .frame(width: size.width / 2)
                        }
                    }
                }
                
            }
            .onAppear {
                isGameDataAvailable = UserDefaults.standard.data(forKey: "gameData") != nil
                if let mode = UserDefaults.standard.string(forKey: "modeGame") {
                    modeGame = mode
                } else {
                    print("No modeGame data found in UserDefaults.")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}


