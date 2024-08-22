//
//  InputInfo.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct InputInfo: View {
    @Binding var playerName: String
    @Binding var numberOfPlayers: Int
    @Binding var showInput: Bool
    @State private var isVisible = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 400, height: 250)
//                    .frame(width: widthRecSize, height: heightRecSize)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
                    .foregroundColor(.white)
//                    .foregroundColor(.blue.opacity(0.3))
                
                VStack {
                    Text("New Game")
                    
                    VStack {
                        HStack {
                            Text("Player Name: ")
                            
                            
                            TextField("Search", text: $playerName)
                                .frame(width: 200)
                                .padding(10)
                                .background(
                                    Capsule()
                                        .strokeBorder(.clear, lineWidth: 0.8)
                                    )
                        }
                        
                        HStack {
                            Text("Number of Player: ")
                            Spacer()
                        }
                        
                        HStack {
                            Text("2 players")
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 2 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 2
                                }
                            
                            Text("3 players")
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 3 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 3
                                }
                            
                            Text("4 players")
                                .padding(10)
                                .overlay {
                                    if numberOfPlayers == 4 {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                    }
                                }
                                .onTapGesture {
                                    numberOfPlayers = 4
                                }
                        }
                        
                       
                                                
                        Button("Confirm") {
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
                    .frame(width: 380)
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
//    GameView()
}
