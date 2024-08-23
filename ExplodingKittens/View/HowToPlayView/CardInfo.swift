//
//  CardInfo.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
//

import SwiftUI

struct CardInfo: View {
    var card: Card
    var body: some View {
        HStack {
            card.frontImage
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack(spacing: 15) {
                Text(card.name)
                    .font(Font.custom("Quicksand-Bold", size: 32))
                                
                Text(card.description)
                    .font(Font.custom("Quicksand-Regular", size: 20))
            }
        }
    }
}

#Preview {
    CardInfo(card: cards[6])
}
