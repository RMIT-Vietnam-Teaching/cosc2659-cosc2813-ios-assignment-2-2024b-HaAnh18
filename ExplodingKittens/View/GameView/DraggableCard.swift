//
//  DraggableCard.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct DraggableCard: View {
    var card: Card
    @State private var offset = CGSize.zero
    @State private var startPosition = CGSize.zero
    
    var body: some View {
        card.frontImage
            .resizable()
            .scaledToFit()
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = CGSize(
                            width: gesture.translation.width + startPosition.width,
                            height: gesture.translation.height + startPosition.height
                        )
                    }
                    .onEnded { _ in
                        startPosition = offset
                    }
            )
    }
}

#Preview {
    DraggableCard(card: cards[0])
//    GameView(numberOfPlayers: 2)
}
