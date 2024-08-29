//
//  CardInfo.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
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

struct CardInfo: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    var card: Card
    var body: some View {
        HStack {
            card.frontImage
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack(spacing: 15) {
                Text(localizationManager.localizedString(for: card.name))
                    .font(Font.custom("Quicksand-Bold", size: 32))
                                
                Text(localizationManager.localizedString(for: card.description))
                    .font(Font.custom("Quicksand-Regular", size: 20))
            }
        }
    }
}

#Preview {
    CardInfo(card: cards[6])
        .environmentObject(LocalizationManager()) // Inject the LocalizationManager for the preview

}
