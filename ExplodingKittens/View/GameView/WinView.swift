//
//  WinView.swift
//  ExplodingKittens
//
//  Created by Nana on 19/8/24.
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

struct WinView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var isVisible = false
    @State private var isZoom = false
    @State private var showReturn = false

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                GifImage(name: "winning")
                    .ignoresSafeArea()
                    .frame(width: size.width, height: size.height)
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color("game-view-bg").opacity(0.5))
                
                VStack(spacing: 30) {
                    Text("Winning", manager: localizationManager)
                        .font(Font.custom("Quicksand-Bold", size: 51))
                        .scaleEffect(isZoom ? 4 : 1)
                    
                    if showReturn {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Return")
                                .modifier(confirmButton())
                        })
                    }
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
                withAnimation(.easeInOut(duration: 1.0)){
                    isZoom = false
                    showReturn = true
                }
            }
        }
    }

}

#Preview {
    WinView()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

//    MenuView()
//    GameView(numberOfPlayers: 2)
}
