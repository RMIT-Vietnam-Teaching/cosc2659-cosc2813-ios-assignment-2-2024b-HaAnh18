//
//  HowToPlay.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct HowToPlay: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            Color ("game-view-bg")
                .ignoresSafeArea()
            
            ScrollView {
                ZStack {
                    
                    
                    
                    VStack {
                        Text("How To Play")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        
                        VStack {
                            Text("1. Take Turns:")
                                .font(.headline)
                                .bold()
                            + Text(" Each player takes turns drawing one card from the deck.")
                                .font(.body)
                            
                            Text("2. Play Cards: ")
                                .font(.headline)
                                .bold()
                            + Text(" On your turn, you can play as many cards as you like before drawing a card. Some cards let you skip your turn, attack other players, or peek at the deck, among other actions.")
                                .font(.body)
                            
                            Text("3. Draw a Card: ")
                                .font(.headline)
                                .bold()
                            + Text(" After playing your cards, you must draw a card from the deck unless you have played a card that allows you to skip drawing. If you draw an Exploding Kitten:.")
                                .font(.body)
                            
                            Text("- Defuse it: ")
                                .font(.headline)
                                .bold()
                            + Text(" After playing your cards, you must draw a card from the deck unless you have played a card that allows you to skip drawing. If you draw an Exploding Kitten:.")
                                .font(.body)
                            
                            Text("- No Defuse?: ")
                                .font(.headline)
                                .bold()
                            + Text(" If you don’t have a Defuse card, you’re out of the game.")
                                .font(.body)
                            
                            Text("4. Continue")
                                .font(.headline)
                                .bold()
                            + Text(" until only one player remains. The last player who has not exploded wins the game.")
                                .font(.body)
                            
                        }
                        
                        
                    }
                    .frame(width: size.width - 100)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 20)
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
//                            .frame(width: size.width - 100)
                            .foregroundColor(Color("lightblue"))
                    }
                }
                .frame(width: size.width, height: size.height) // Ensures ZStack fills the entire GeometryReader

            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HowToPlay()
}
