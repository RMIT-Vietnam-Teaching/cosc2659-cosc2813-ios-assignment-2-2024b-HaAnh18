//
//  Settings.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
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

struct Settings: View {
    // Injects the current view's presentation mode into the view, allowing it to dismiss itself.
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    // Injects a shared instance of LocalizationManager into the view, allowing access to localization settings.
    @EnvironmentObject var localizationManager: LocalizationManager
    
    // Injects a shared instance of AudioManager into the view, allowing control over audio playback.
    @EnvironmentObject var audioManager: AudioManager

    // State variable to control the visibility of a sheet (modal view) in the UI.
    @State private var showingSheet: Bool = false

    @Binding var modeGame: String
    @Binding var language: String
    @Binding var appearanceMode: AppearanceMode
    @Binding var colorScheme: ColorScheme?
    @Binding var appearance: String
    @Binding var theme: String

    // Arrays to hold the available options for various settings, used for selection in the UI.
    let languageOptions = ["English", "Vietnamese"]
    let modeOptions = ["Easy", "Medium", "Hard"]
    let appearanceOptions = ["Light", "Dark", "System"]
    let themeOptions = ["Rabbit", "Kitten"]

    var body: some View {
        ZStack(alignment: .top) {
            Color("game-view-bg")
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    // Button to dismiss the current view and return to the previous screen.
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("custom-black"))

                        Text("Menu", manager: localizationManager)
                            .font(Font.custom("Quicksand-Regular", size: 24))
                            .foregroundColor(Color("custom-black"))
                    })
                    
                    Spacer()
                }
                .frame(height: 30)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                VStack(spacing: 40) {
                    Text("Settings", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 40))
                                            
                    VStack{
                        HStack(spacing: 20) {
                            HStack {
                                Spacer()
                                Text("Level:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 24))
                            }
                            .frame(width: 250)

                                

                            HStack {
                                // A custom drop-down view that binds the selected value to a state variable and updates UserDefaults when the selection changes.
                                DropDownView(selection: $modeGame, options: modeOptions)
                                    .onChange(of: modeGame, initial: true) {
                                        oldValue, newValue in
                                        // When the selected game mode changes, update the stored value in UserDefaults.
                                        UserDefaults.standard.set(modeGame, forKey: "modeGame")

                                    }
                                Spacer()
                            }
                            .frame(width: 250)
                        }
                        
                        
                        HStack(spacing: 20) {
                            HStack {
                                Spacer()
                                Text("Language:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 24))

                            }
                            .frame(width: 250)

                            
                            HStack {
                                // A custom drop-down view that binds the selected language to a state variable and updates the app's language setting.
                                DropDownView(selection: $language, options: languageOptions)
                                    .onChange(of: language, initial: true) {
                                        oldValue, newValue in
                                        // When the language selection changes, call the changeLanguage() function to update the app's language.
                                        changeLanguage()
                                        
                                        // Save the selected language to UserDefaults so it persists between app launches.
                                        UserDefaults.standard.set(language, forKey: "language")
                                    }
                                
                                Spacer()
                            }
                            .frame(width: 250)
                        }
                        
                        HStack(spacing: 20) {
                            HStack {
                                Spacer()
                                Text("Theme:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 24))
                            }
                            .frame(width: 250)

                            
                            HStack {
                                // A custom drop-down view that binds the selected theme to a state variable and updates UserDefaults when the selection changes.
                                DropDownView(selection: $theme, options: themeOptions)
                                    .onChange(of: theme, initial: true) {
                                        oldValue, newValue in
                                        // When the theme selection changes, save the selected theme to UserDefaults.
                                        UserDefaults.standard.set(theme, forKey: "theme")
                                    }
                                
                                Spacer()
                            }
                            .frame(width: 250)
                        }
                        
                        HStack(spacing: 20) {
                            HStack {
                                Spacer()
                                Text("Appearance:", manager: localizationManager)
                                    .font(Font.custom("Quicksand-Medium", size: 24))
                            }
                            .frame(width: 250)

                            
                            HStack {
                                // A custom drop-down view that binds the selected appearance mode to a state variable and updates the app's appearance settings.
                                DropDownView(selection: $appearance, options: appearanceOptions)
                                    .onChange(of: appearance, initial: true) {
                                        oldValue, newValue in
                                        // When the appearance selection changes, update the appearanceMode and colorScheme based on the new value.
                                        if newValue == "Light" {
                                            // Set appearance mode and color scheme to light.
                                            appearanceMode = .light
                                            colorScheme = .light

                                        } else if newValue == "Dark" {
                                            // Set appearance mode and color scheme to dark.
                                            appearanceMode = .dark
                                            colorScheme = .dark
                                            
                                        } else {
                                            // Set appearance mode to system default and clear the color scheme (use system setting).
                                            appearanceMode = .system
                                            colorScheme = nil
                                        }
                                        
                                        UserDefaults.standard.set(appearance, forKey: "appearance")

                                    }
                                
                                Spacer()
                            }
                            .frame(width: 250)
                        }
                    }
                }
                .frame(width: 500)
            }
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden(true)
            .onDisappear {
                // Save the current game mode to UserDefaults under the key "difficultyMode".
                UserDefaults.standard.set(modeGame, forKey: "difficultyMode")
                
                // Save the current language setting to UserDefaults under the key "language".
                UserDefaults.standard.set(language, forKey: "language")
                
                // Save the current appearance mode to UserDefaults under the key "appearance".
                UserDefaults.standard.set(appearance, forKey: "appearance")
                
                // Save the current theme setting to UserDefaults under the key "theme".
                UserDefaults.standard.set(theme, forKey: "theme")
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    // Button that toggles the visibility of a sheet when pressed.
                    Button(action: {
                        // Toggle the state of `showingSheet`, which controls the presentation of the sheet.
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 24))
                            .foregroundColor(Color("custom-black"))
                    })
                    // Present a sheet when `showingSheet` is true.
                    .sheet(isPresented: $showingSheet) {
                        // The content of the sheet, which is a view named `TabViewModeGame`.
                        // The `showingSheet` binding is passed down to control the sheet's visibility.
                        TabViewModeGame(showingSheet: $showingSheet)
                    }
                }
            }
        }
    }
    
    // A private function to change the app's language based on the selected language.
    private func changeLanguage() {
        // Check if the selected language is Vietnamese.
        if language == "Vietnamese" {
            // If so, instruct the localization manager to switch the app's language to Vietnamese (code "vi").
            localizationManager.changeLanguage(to: "vi")
        } else {
            // Otherwise, default to English (code "en").
            localizationManager.changeLanguage(to: "en")
        }
    }
}

#Preview {
//    Settings(modeGame: .constant("Easy"), language: .constant("English"), appearanceMode: .constant(.light), colorScheme: .constant(.light), appearance: .constant("Light"))
    MenuView()
}

// Enum to represent the different appearance modes available in the app.
enum AppearanceMode {
    case dark, light, system
}
