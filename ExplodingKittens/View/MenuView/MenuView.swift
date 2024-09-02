//
//  MenuView.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
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

struct MenuView: View {
    @StateObject private var localizationManager = LocalizationManager()
    @StateObject private var audioManager = AudioManager()

    @State private var isGameDataAvailable: Bool?
    @State private var language: String = "English"
    @State private var appearanceMode: AppearanceMode = .light
    @State private var colorScheme: ColorScheme? = .light
    @State private var appearance: String = "Light"
    @State private var modeGame: String = "Easy"
    @State private var theme: String = "Rabbit"

    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                let sizeCategory = getScreenSizeCategory(for: size)
                
                ZStack {
                    Color("game-view-bg")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Exploding Kittens", manager: localizationManager)
                            .font(Font.custom("Quicksand-Bold", size: 40))
                        
                        if sizeCategory == .medium || sizeCategory == .small {
                            HStack(spacing: 0) {
                                Image(theme == "Rabbit" ? "exploding-kitten-2" : "exploding-kitten")
                                    .resizable()
                                    .frame(width: 250, height: 250)
                                
                                VStack(alignment: .leading) {
                                    VStack(spacing: 10) {
                                        if isGameDataAvailable != nil && isGameDataAvailable == true {
                                            // Only show the NavigationLink if isGameDataAvailable is not nil and is true.
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
                                        
                                        NavigationLink(destination: PlayCardTutorial( theme: $theme)) {
                                            Text("Tutorial", manager: localizationManager)
                                                .modifier(buttonCapsule())
                                        }
                                        
                                        NavigationLink(destination: Settings(modeGame: $modeGame, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance, theme: $theme)) {
                                            Text("Settings", manager: localizationManager)
                                                .modifier(buttonCapsule())
                                        }
                                    }
                                }
                                .frame(width: size.width / 2)
                            }
                        } else {
                            // Display the MenuViewIpad for larger size categories.
                            MenuViewIpad(isGameDataAvailable: $isGameDataAvailable, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance, modeGame: $modeGame, theme: $theme)
                        }
                    }
                }
            }
            .onAppear {
                // Check if game data is available
                if isGameDataAvailable == nil {
                    // Check if there is any saved game data in UserDefaults
                    isGameDataAvailable = UserDefaults.standard.data(forKey: "gameData") != nil
                }
                
                // Retrieve the game mode from UserDefaults
                if let mode = UserDefaults.standard.string(forKey: "modeGame") {
                    modeGame = mode
                } else {
                    // Print a message if no game mode data is found
                    print("No modeGame data found in UserDefaults.")
                }
                
                // Retrieve the language setting from UserDefaults
                if let language = UserDefaults.standard.string(forKey: "language") {
                    self.language = language
                } else {
                    // Print a message if no language data is found
                    print("No modeGame data found in UserDefaults.")
                }
                
                // Retrieve the theme setting from UserDefaults
                if let themeGame = UserDefaults.standard.string(forKey: "theme") {
                    self.theme = themeGame
                } else {
                    // Print a message if no theme data is found
                    print("No modeGame data found in UserDefaults.")
                }
                
                if let appearance = UserDefaults.standard.string(forKey: "appearance") {
                    if appearance == "Light" {
                        // Set appearance mode and color scheme to light.
                        appearanceMode = .light
                        colorScheme = .light

                    } else if appearance == "Dark" {
                        // Set appearance mode and color scheme to dark.
                        appearanceMode = .dark
                        colorScheme = .dark
                    } else {
                        // Set appearance mode to system default and clear the color scheme (use system setting).
                        appearanceMode = .system
                        colorScheme = nil
                    }
                }
                
                // Play background music
                audioManager.playBackgroundMusic(fileName: "background", fileType: "mp3")
            }
        }
        .preferredColorScheme(colorScheme) // Set the preferred color scheme
        .environmentObject(localizationManager)
        .environmentObject(audioManager)
    }
}

#Preview {
    MenuView()
}


