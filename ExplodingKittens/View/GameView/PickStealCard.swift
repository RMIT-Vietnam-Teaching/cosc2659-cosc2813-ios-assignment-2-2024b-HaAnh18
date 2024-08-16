//
//  PickStealCard.swift
//  ExplodingKittens
//
//  Created by Nana on 16/8/24.
//

import SwiftUI

struct PickStealCard: View {
    @Binding var cards: [Card]
    @State private var chosenCard: Card?
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: size.width / 2 + 300, height: size.height - 100)
                    .alignmentGuide(.leading) { d in
                        (size.width - d.width) / 2
                    }
                    .alignmentGuide(.top) { d in
                        (size.height - d.height) / 2
                    }
//                    .foregroundColor(.white)
                    .foregroundColor(.yellow)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(cards, id: \.self) {
                            card in
                            VStack {
                                card.frontImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .padding(-10)
//                                    .background(.pink)
                                
                                Button(action: {
                                    chosenCard = card
                                }, label: {
                                    Text("Choose")
                                        .modifier(buttonCapsule())
                                })
                            }
                        }
                    }
                }
                .frame(width: size.width - 100)
                
            }
            .ignoresSafeArea()
            .frame(width: size.width, height: size.height)
        }
    }
}

#Preview {
    PickStealCard(cards: .constant(cards))
}
