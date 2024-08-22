//
//  SeeFutureDialog.swift
//  ExplodingKittens
//
//  Created by Nana on 15/8/24.
//

import SwiftUI

struct SeeFutureDialog: View {
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
                            Text("Top Card")
                                .offset(y: -10)
                            
                            cards[cards.count - 1].frontImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                
                        }
                        .rotationEffect(.degrees(self.open ? -10 : 0))
                        .offset(x: self.open ? -50 : 0, y: self.open ? 50 : 0)
                        .animation(.easeInOut, value: open)
                    }
                  
                    Text("Got it")
                        .modifier(buttonCapsule())
                        .onTapGesture {
                            withAnimation {
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
//        .scaleEffect(isVisible ? 1 : 0.5) // Adjust the scale effect for animation
        .opacity(isVisible ? 1 : 0)
    }
}

#Preview {
//    SeeFutureDialog(seeFuture: .constant(true), cards: cards)
    MenuView()

//    GameView(numberOfPlayers: 2)
}
