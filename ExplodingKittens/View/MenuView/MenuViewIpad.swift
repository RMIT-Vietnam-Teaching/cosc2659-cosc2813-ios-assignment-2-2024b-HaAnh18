//
//  MenuViewIpad.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
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

struct MenuViewIpad: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var isGameDataAvailable: Bool?
    @Binding var language: String
    @Binding var appearanceMode: AppearanceMode
    @Binding var colorScheme: ColorScheme?
    @Binding var appearance: String
    @Binding var modeGame: String
    @Binding var theme: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(theme == "Rabbit" ? "exploding-kitten-2" : "exploding-kitten")
                .resizable()
                .frame(width: 300, height: 300)
            
            VStack(alignment: .leading) {
                VStack(spacing: 10) {
                    if isGameDataAvailable != nil && isGameDataAvailable == true {
                        NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, theme: $theme, resumeGame: true)) {
                            Text("Resume Game", manager: localizationManager)
                                .modifier(buttonCapsule())
                        }
                    }
                    
                    NavigationLink(destination: GameView(isGameDataAvailable: $isGameDataAvailable, modeGame: $modeGame, theme: $theme, resumeGame: false)) {
                        Text("New Game", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: Leaderboard()) {
                        Text("Leaderboard", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: PlayCardTutorial(theme: $theme)) {
                        Text("Tutorial", manager: localizationManager)
                            .modifier(buttonCapsule())
                    }
                    
                    NavigationLink(destination: Settings(modeGame: $modeGame, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance, theme: $theme)) {
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
