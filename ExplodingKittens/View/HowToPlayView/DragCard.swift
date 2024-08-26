//
//  DragCard.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
//

import SwiftUI

struct DragCard: View {
    let dropZoneSize: CGSize
    let card: Card
    @Binding var isDragging: Bool
    @Binding var isCardInDropZone: Bool
    @Binding var cardOffset: CGSize
    @Binding var currentCard: Card?
    let cardIndex: Int // Index of the card
    let dropZoneFrame: CGRect // Drop zone frame
    @Binding var cardVisible: Bool // Track visibility of the card
    @State private var cardSize: CGFloat = 10
    var screenSize: ScreenSizeCategory

    var body: some View {
        ZStack {
            card.frontImage
//                .foregroundColor(.blue)
                .resizable()
                .scaledToFit()
                .frame(width: cardSize, height: cardSize)
                .offset(cardOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.cardOffset = gesture.translation
                            self.isDragging = true
                        }
                        .onEnded { _ in
                            self.isDragging = false
                            
                            // Calculate the card's center position in global coordinates
                            let cardCenterX = self.cardOffset.width + cardSize / 2
                            let cardCenterY = self.cardOffset.height + cardSize / 2
                            
                            
                            // Check if the card is fully within the drop zone bounds using global coordinates
                            let isInsideDropZone =
                                (cardCenterX  < dropZoneFrame.maxY)
                            &&
                                (cardCenterY + dropZoneFrame.minY < dropZoneFrame.minY)
                            &&
                                (cardCenterY + dropZoneFrame.minY < dropZoneFrame.maxY)
                            
                            if isInsideDropZone {
                                // Card is in the drop zone, so make it disappear
                                withAnimation {
                                    currentCard = card
                                    self.cardVisible = false
                                    self.isCardInDropZone = true
                                }
                            } else {
                                // Reset the card to its original position
                                withAnimation {
                                    self.cardOffset = .zero
                                    self.isCardInDropZone = false
                                }
                            }
                        }
                )
        }
        .animation(.easeInOut(duration: 0.3), value: isDragging)
        .onAppear {
            setComponentSize()
        }
    }
        
    
    func setComponentSize() {
        switch screenSize {
        case .small:
            cardSize = 140
        case .medium:
            cardSize = 150
        case .large:
            cardSize = 200
        case .extraLarge:
            cardSize = 120
        }
    }

}

#Preview {
    PlayCardTutorial()
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
