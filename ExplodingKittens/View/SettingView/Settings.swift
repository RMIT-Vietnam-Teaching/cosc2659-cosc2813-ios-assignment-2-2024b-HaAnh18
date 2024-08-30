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
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var localizationManager: LocalizationManager
    @EnvironmentObject var audioManager: AudioManager

    @State private var showingSheet: Bool = false

    @Binding var modeGame: String
    @Binding var language: String
    @Binding var appearanceMode: AppearanceMode
    @Binding var colorScheme: ColorScheme?
    @Binding var appearance: String
    @Binding var theme: String

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
                                DropDownView(selection: $modeGame, options: modeOptions)
                                    .onChange(of: modeGame, initial: true) {
                                        oldValue, newValue in
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
                                DropDownView(selection: $language, options: languageOptions)
                                    .onChange(of: language, initial: true) {
                                        oldValue, newValue in
                                        changeLanguage()
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
                                DropDownView(selection: $theme, options: themeOptions)
                                    .onChange(of: theme, initial: true) {
                                        oldValue, newValue in
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
                                DropDownView(selection: $appearance, options: appearanceOptions)
                                    .onChange(of: appearance, initial: true) {
                                        oldValue, newValue in
                                        if newValue == "Light" {
                                            appearanceMode = .light
                                            colorScheme = .light

                                        } else if newValue == "Dark" {
                                            appearanceMode = .dark
                                            colorScheme = .dark
                                        } else {
                                            appearanceMode = .system
                                            colorScheme = nil
                                        }
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
                UserDefaults.standard.set(modeGame, forKey: "difficultyMode")
                UserDefaults.standard.set(language, forKey: "language")
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 24))
//                            .padding(24)
                            .foregroundColor(Color("custom-black"))
//                            .background(.pink)
                    })
                    .sheet(isPresented: $showingSheet) {
                        TabViewModeGame(showingSheet: $showingSheet)
                    }
                }
            }
        }
    }
    private func changeLanguage() {
            if language == "Vietnamese" {
                localizationManager.changeLanguage(to: "vi")
            } else {
                localizationManager.changeLanguage(to: "en")
            }
        }
}

#Preview {
//    Settings(modeGame: .constant("Easy"), language: .constant("English"), appearanceMode: .constant(.light), colorScheme: .constant(.light), appearance: .constant("Light"))
    MenuView()
}

enum AppearanceMode {
    case dark, light, system
}
