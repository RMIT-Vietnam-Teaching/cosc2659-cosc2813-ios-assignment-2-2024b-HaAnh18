//
//  DropDestination.swift
//  ExplodingKittens
//
//  Created by Nana on 11/8/24.
//

import SwiftUI

struct DropDestination: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    @State private var dropSize: CGFloat? = nil
    @State private var cardSize: CGFloat? = nil
    @Binding var droppedCards: [Card]
    var screenSize: ScreenSizeCategory
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                .frame(width: dropSize, height: dropSize)
            
            if droppedCards.count == 0 {
                Text("Drop Your Card Here", manager: localizationManager)
                    .font(Font.custom("Quicksand-Medium", size: 24))
                    .frame(width: dropSize)
                    .multilineTextAlignment(.center)
            }
            
            ForEach(droppedCards.indices, id: \.self) { index in
                let card = droppedCards[index]
                card.frontImage
                    .resizable()
                    .rotationEffect(.degrees(index % 2 == 0 ? Double(index) * 1 : Double(index) * -1))
                    .frame(width: cardSize, height: cardSize)
                    .scaledToFit()
            }
            .frame(width: 160, height: 160)
            .onChange(of: droppedCards, initial: true) {
                oldValue, newValue in
//                checkPlayerCard(card: droppedCards[droppedCards.count - 1])
            }
            
        }
        .onAppear {
            setComponentSize()
        }
    }
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            dropSize = 150
            cardSize = 140
        case .medium:
            dropSize = 160
            cardSize = 150
        case .large:
            dropSize = 220
            cardSize = 220
        case .extraLarge:
            dropSize = 120
            cardSize = 100
        }
    }
}

#Preview {
//    DropDestination()
    MenuView()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

//    GameView(numberOfPlayers: 4)
}
