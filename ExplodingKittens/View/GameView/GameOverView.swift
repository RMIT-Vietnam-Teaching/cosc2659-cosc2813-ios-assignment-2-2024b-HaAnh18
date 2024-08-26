//
//  GameOverView.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
//

import SwiftUI

struct GameOverView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var isVisible = false
    @State private var isZoom = false
    @State private var showReturn = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                
                GifImage(name: "exploding")
                    .ignoresSafeArea()
                    .frame(width: size.width, height: size.height)
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color("game-view-bg").opacity(0.5))
               
                VStack(spacing: 30) {
  
                    Text("Gameover", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 62))
                        .scaleEffect(isZoom ? 3 : 1)
                    
//                    if showReturn {
//                        Text("Return", manager: localizationManager)
//                            .modifier(confirmButton())
//                    }
                }
            }
        }
        .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                isVisible = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isZoom = true
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1.0)){     isZoom = false
                    showReturn = true
                }
            }
        }
    }
}

#Preview {
    GameOverView()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
//    MenuView()
//    GameView(numberOfPlayers: 2)
}
