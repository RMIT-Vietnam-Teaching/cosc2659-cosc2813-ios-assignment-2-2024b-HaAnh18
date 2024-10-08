//
//  DragCard1.swift
//  ExplodingKittens
//
//  Created by Nana on 24/8/24.
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
 https://www.hackingwithswift.com/books/ios-swiftui/moving-views-with-draggesture-and-offset
*/

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
    @Binding var currentScore: Int
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
    
    // Case for the "Skip" card: Decreases the current player's turn count by 1.
    func checkPlayerCard(card: Card) {
        switch card.name {
        case "Skip":
            playerList[currentTurn].numberOfTurn -= 1
            playerList[currentTurn].score += card.score
            
            // If the current player has no turns left, reset their turn count to 1 and move to the next player.
            if playerList[currentTurn].numberOfTurn == 0 {
                playTurn = false
                playerList[currentTurn].numberOfTurn = 1
                currentTurn = (currentTurn + 1) % playerList.count
            }
            break
            
        // Case for the "Attack" card: Decreases the current player's turn count by 1,
        // and adds an extra turn to the next player in the sequence.
        case "Attack":
            playerList[currentTurn].numberOfTurn = 0
            playerList[(currentTurn + 1) % playerList.count].numberOfTurn += 1
            playerList[currentTurn].score += card.score
            
            // If the current player has no turns left, reset their turn count to 1 and move to the next player.
            if playerList[currentTurn].numberOfTurn == 0 {
                playTurn = false
                playerList[currentTurn].numberOfTurn = 1
                currentTurn = (currentTurn + 1) % playerList.count
            }
            break
            
        // Case for the "See The Future" card: Increases the player's score and allows
        // the player to preview the upcoming cards after a brief delay.
        case "See The Future":
            playerList[currentTurn].score += card.score
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                seeFuture = true
            }
            break
            
        // Case for the "Steal A Card" card: Allows the player to steal a card from another player.
        // If there are more than 2 players, the player can choose whom to steal from.
        // If there are only 2 players, the AI gives a card to the player.
        case "Steal A Card":
            if playerList.count > 2 {
                stealOther = true
            } else {
                withAnimation{
                    aiGiveCard(to: &playerCards, from: &playerList[1].cards)
                }
            }
            playerList[currentTurn].score += card.score
            break
            
        // Case for the "Shuffle" card: Shuffles the remaining cards in the deck and
        // increases the player's score.
        case "Shuffle":
            cardGame.shuffle()
            playerList[currentTurn].score += card.score
            break
            
        // Default case: If the card name doesn't match any recognized cases, no action is taken.
        default:
            break
        }
    }
}

#Preview {
    MenuView()
}
