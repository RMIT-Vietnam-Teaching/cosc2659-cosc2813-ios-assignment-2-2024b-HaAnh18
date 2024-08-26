//
//  MenuView.swift
//  ExplodingKittens
//
//  Created by Nana on 20/8/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var localizationManager = LocalizationManager()

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
                let sizeCategory = getScreenSizeCategory(for: size)
                
                ZStack {
                    Color("game-view-bg")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Exploding Kittens", manager: localizationManager)
                            .font(Font.custom("Quicksand-Bold", size: 40))
                        
                        if sizeCategory == .medium || sizeCategory == .small {
                            HStack(spacing: 0) {
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
                                .frame(width: size.width / 2)
                            }
                        } else {
                            MenuViewIpad(isGameDataAvailable: $isGameDataAvailable, language: $language, appearanceMode: $appearanceMode, colorScheme: $colorScheme, appearance: $appearance, modeGame: $modeGame)
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
                
                if let language = UserDefaults.standard.string(forKey: "language") {
                    self.language = language
                } else {
                    print("No modeGame data found in UserDefaults.")
                }
            }
        }
        .preferredColorScheme(colorScheme) // Set the preferred color scheme
        .environmentObject(localizationManager)

    }
    
  
    
}

#Preview {
    MenuView()
//        .environment(\.locale, Locale(identifier: "VI"))

}


