//
//  ContentView.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct ContentView: View {
//    @AppStorage("MyLanguages") var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
//    
//    @EnvironmentObject var languageManager: LanguageManager
//    @State private var isLanguageSelectionActive = false
//    
    @StateObject private var localizationManager = LocalizationManager()

    @State private var lan: String = "English"

    var body: some View {
//        LandscapeViewControllerRepresentable()
//        GameView(numberOfPlayers: 2)
//        Test(numberOfPlayers: 2)
        MenuView()
//        VStack(spacing: 20) {
//            Text("Menu", manager: localizationManager)
//
//                    Button(action: {
//                        lan = "English"
//                    }) {
//                        Text(localizationManager.localizedString(for: "English"))
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//            
//            Button(action: {
//                lan = "Vietnamese"
//            }) {
//                Text(localizationManager.localizedString(for: "Vietnamese"))
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//                }
//                .padding()
//                .onChange(of: lan, initial: true) {
//                    _,_ in
//                    toggleLanguage()
//                }
//                .environmentObject(localizationManager)
    
//        PlayCardTutorial()
//            .font(Font.custom("GreatVibes-Regular", size: 20))
//        Text("\(AppDelegate.orientationLock)")
    }
    
    private func toggleLanguage() {
            if lan == "Vietnamese" {
                localizationManager.changeLanguage(to: "vi")
            } else {
                localizationManager.changeLanguage(to: "en")
            }
        }
    
}

#Preview {
    ContentView()
//        .environment(\.locale, Locale(identifier: "VI"))
}
