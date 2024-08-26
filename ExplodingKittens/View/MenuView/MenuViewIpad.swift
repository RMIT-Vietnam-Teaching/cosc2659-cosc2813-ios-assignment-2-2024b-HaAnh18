//
//  MenuViewIpad.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
//

import SwiftUI

struct MenuViewIpad: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var isGameDataAvailable: Bool
    @Binding var language: String
    @Binding var appearanceMode: AppearanceMode
    @Binding var colorScheme: ColorScheme?
    @Binding var appearance: String
    @Binding var modeGame: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image("exploding-kitten")
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack(alignment: .leading) {
                VStack(spacing: 10) {
                    if isGameDataAvailable {
                        NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, resumeGame: true)) {
                            Text("Resume Game", manager: localizationManager)
                                .modifier(buttonCapsule())
                        }
                    }
                    
                    NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, resumeGame: false)) {
                        Text("New Game", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: Leaderboard()) {
                        Text("Leaderboard", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: PlayCardTutorial()) {
                        Text("Tutorial", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: Settings(modeGame: $modeGame, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance)) {
                        Text("Settings", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                }
            }
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
