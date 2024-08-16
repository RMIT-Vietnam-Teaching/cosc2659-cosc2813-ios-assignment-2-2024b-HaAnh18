//
//  DropDestination.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct DropDestination: View {
    @Binding var droppedCards: [Card]
    @Binding var playTurn: Bool
    @Binding var draggedCard: Card?
    @Binding var playerCards: [Card]
    @Binding var currentCard: Card?
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                .frame(width: 155, height: 155)
            
            if droppedCards.count == 0 {
                Text("Drop Your Card Here")
                    .frame(width: 120)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            
            ForEach(droppedCards.indices, id: \.self) { index in
                let card = droppedCards[index]
                card.frontImage
                    .resizable()
                    .rotationEffect(.degrees(index % 2 == 0 ? Double(index) * 1 : Double(index) * -1))
                    .frame(width: 150, height: 150)
                    .scaledToFit()
            }
            .frame(width: 160, height: 160)
            
        }
        .onDrop(of: ["public.text"], isTargeted: nil) { providers in
            guard playTurn else {
                return false // Prevent drop if playTurn is false
            }
            
            if let draggedCard = draggedCard {
                withAnimation {
                    playerCards.removeAll { $0 == draggedCard }
                    currentCard = draggedCard
                    droppedCards.append(draggedCard)
                }
            }
            draggedCard = nil
            return true
        }
    }
}

#Preview {
//    DropDestination()
    GameView(numberOfPlayers: 4)
}
