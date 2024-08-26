//
//  InputInfo.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct InputInfo: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var playerName: String
    @Binding var numberOfPlayers: Int
    @Binding var showInput: Bool
    @State private var isVisible = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 400, height: 300)
//                    .frame(width: widthRecSize, height: heightRecSize)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
                    .foregroundColor(Color("custom-white"))
//                    .foregroundColor(.blue.opacity(0.3))
                
                VStack(spacing: 20) {
                    Text("New Game", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 32))
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Player Name:", manager: localizationManager)
                                .font(Font.custom("Quicksand-Medium", size: 20))
                            
                            
                            TextField(localizationManager.localizedString(for:"Type your name"), text: $playerName)
                                .frame(width: 200)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color("game-view-bg"), lineWidth: 1)
                                    )
                        }
                        
                        HStack {
                            Text("Number of Player: ", manager: localizationManager)
                                .font(Font.custom("Quicksand-Medium", size: 20))
                            Spacer()
                        }
                        
                        HStack {
                            Text("2 players", manager: localizationManager)
                                .font(Font.custom("Quicksand-Regular", size: 18))
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 2 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("game-view-bg"), lineWidth: 3)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 2
                                }
                            
                            Text("3 players", manager: localizationManager)
                                .font(Font.custom("Quicksand-Regular", size: 18))
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 3 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("game-view-bg"), lineWidth: 3)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 3
                                }
                            
                            Text("4 players", manager: localizationManager)
                                .font(Font.custom("Quicksand-Regular", size: 18))
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 4 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("game-view-bg"), lineWidth: 3)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 4
                                }
                        }
                    }
                    .frame(width: 380)
                    
                    Button(localizationManager.localizedString(for:"Confirm")) {
                        withAnimation{
                            isVisible = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showInput = false
                            }
                        }
                    }
                    .modifier(buttonCapsule())
                    .disabled(playerName.isEmpty) // Disable button if name is empty
                }
            }
            .frame(width: size.width, height: size.height)
            .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isVisible = true
                }
            }
        }
        
    }
}

#Preview {
//    InputInfo()
    MenuView()
//    GameView(isGameDataAvailable: .constant(false), resumeGame: false)
}
