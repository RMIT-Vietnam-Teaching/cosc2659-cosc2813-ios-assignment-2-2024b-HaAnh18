//
//  DragCard.swift
//  ExplodingKittens
//
//  Created by Nana on 21/8/24.
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

struct DragCard: View {
    let card: Card
    let dropZoneFrame: CGRect // Drop zone frame
    @Binding var cardOffset: CGSize
    @Binding var currentCard: Card?
    @Binding var cardVisible: Bool // Track visibility of the card
    var screenSize: ScreenSizeCategory

    var body: some View {
        ZStack {
            card.frontImage
                .resizable()
                .scaledToFit()
                .frame(width: screenSize == .small ? 140 : screenSize == .medium ? 150 : 200, height: screenSize == .small ? 140 : screenSize == .medium ? 150 : 200)
                .offset(cardOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.cardOffset = gesture.translation
//                            self.isDragging = true
                        }
                        .onEnded { _ in
//                            self.isDragging = false
                            
                            // Calculate the card's center position in global coordinates
                            let cardSize = screenSize == .small ? 140 : screenSize == .medium ? 150 : 200
                            let cardCenterX = self.cardOffset.width + CGFloat(cardSize / 2)
                            let cardCenterY = self.cardOffset.height + CGFloat(cardSize / 2)
                            
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
                                }
                            } else {
                                // Reset the card to its original position
                                withAnimation {
                                    self.cardOffset = .zero
                                }
                            }
                        }
                )
        }
    }
}

#Preview {
    PlayCardTutorial(theme: .constant("Rabbit"))
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview
}
