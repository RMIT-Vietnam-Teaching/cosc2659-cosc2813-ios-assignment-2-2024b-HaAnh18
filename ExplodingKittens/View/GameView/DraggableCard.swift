//
//  DragCard1.swift
//  ExplodingKittens
//
//  Created by Nana on 24/8/24.
//

import SwiftUI

struct DraggableCard: View {
    @EnvironmentObject var audioManager: AudioManager

    let card: Card
    let dropZoneFrame: CGRect // Drop zone frame
    @Binding var currentTurn: Int
    @Binding var playerList: [Player]
    @Binding var playTurn: Bool
    @Binding var seeFuture: Bool
    @Binding var stealOther: Bool
    @Binding var cardGame: [Card]
    @Binding var cardOffset: CGSize
    @Binding var droppedCards: [Card]
    @Binding var playerCards: [Card]
    var screenSize: ScreenSizeCategory

    var body: some View {
        ZStack {
            card.frontImage
                .resizable()
                .scaledToFit()
                .frame(width: screenSize == .medium ? 150 : screenSize == .small ? 140 : 220, height: screenSize == .medium ? 150 : screenSize == .small ? 140 : 220)
                .offset(cardOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.cardOffset = gesture.translation
                        }
                        .onEnded { _ in
//                            self.isDragging = false
                            
                            let cardSize = screenSize == .medium ? 150 : screenSize == .small ? 140 : 220
                            // Calculate the card's center position in global coordinates
                            let cardCenterX = self.cardOffset.width + CGFloat(cardSize / 2)
                            let cardCenterY = self.cardOffset.height + CGFloat(cardSize / 2)
                            
                            
                            // Check if the card is fully within the drop zone bounds using global coordinates
                            let isInsideDropZone =
                                (cardCenterX  < dropZoneFrame.maxY)
                            &&
                                (cardCenterY + dropZoneFrame.minY < dropZoneFrame.minY)
                            &&
                                (cardCenterY + dropZoneFrame.minY < dropZoneFrame.maxY)
                            
                            if isInsideDropZone && currentTurn == 0 {
                                withAnimation {
                                    checkPlayerCard(card: card)
                                    addCard(card: card, count: 1, to: &droppedCards, remove: true, from: &playerCards)
                                    audioManager.playSoundEffect(sound: "play-card", type: "mp3")
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
    
    func checkPlayerCard(card: Card) {
        switch card.name {
        case "Skip":
            playerList[currentTurn].numberOfTurn -= 1
            
            if playerList[currentTurn].numberOfTurn == 0 {
                playTurn = false
                playerList[currentTurn].numberOfTurn = 1
                currentTurn = (currentTurn + 1) % playerList.count
            }
            break
        case "Attack":
            playerList[currentTurn].numberOfTurn = 0
            playerList[(currentTurn + 1) % playerList.count].numberOfTurn += 1
            
            if playerList[currentTurn].numberOfTurn == 0 {
                playTurn = false
                playerList[currentTurn].numberOfTurn = 1
                currentTurn = (currentTurn + 1) % playerList.count
            }
            break
        case "See The Future":
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                seeFuture = true
            }
            break
        case "Steal A Card":
            if playerList.count > 2 {
                stealOther = true
            } else {
                aiGiveCard(to: &playerCards, from: &playerList[1].cards)
            }
            break
        case "Shuffle":
            cardGame.shuffle()
            break
        default:
            break
        }
    }

}
