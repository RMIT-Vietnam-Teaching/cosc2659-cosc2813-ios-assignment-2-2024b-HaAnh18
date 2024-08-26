//
//  SeeFutureDialog.swift
//  ExplodingKittens
//
//  Created by Nana on 15/8/24.
//

import SwiftUI

struct SeeFutureDialog: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var open: Bool = false
    @State private var isVisible = false
    @Binding var seeFuture: Bool
    var cards: [Card]
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.1)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                
                VStack {
                    ZStack {
                        if cards.count > 2 {
                            cards[cards.count - 3].frontImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                .rotationEffect(.degrees(self.open ? 5 : 0))
                                .offset(x: self.open ? 50 : 0, y: self.open ? -50 : 0)
                                .animation(.easeInOut, value: open)
                        }
                        
                        if cards.count > 1 {
                            cards[cards.count - 2].frontImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                .rotationEffect(.degrees(self.open ? -5 : 0))
                                .offset(x: 0, y: 0)
                                .animation(.easeInOut, value: open)
                        }
                        
                        
                        
                        ZStack(alignment: .top) {
                            Text("Top Card", manager: localizationManager)
                                .font(Font.custom("Quicksand-Regular", size: 20))
                                .offset(y: -10)
                            
                            cards[cards.count - 1].frontImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                
                        }
                        .rotationEffect(.degrees(self.open ? -10 : 0))
                        .offset(x: self.open ? -50 : 0, y: self.open ? 50 : 0)
                        .animation(.easeInOut, value: open)
                    }
                  
                    Text("Got it", manager: localizationManager)
                        .modifier(confirmButton())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isVisible = false
                                seeFuture = false
                            }
                        }
                        .offset(y: 30)
                }
                
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                isVisible = true
            }
            
            withAnimation(.easeInOut(duration: 1.0)) {
                open = true
            }
            

        }
        .opacity(isVisible ? 1 : 0)
    }
}

#Preview {
//    SeeFutureDialog(seeFuture: .constant(true), cards: cards)
//    MenuView()
    SeeFutureDialog(seeFuture: .constant(true), cards: cards)
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

//    GameView(numberOfPlayers: 2)
}

